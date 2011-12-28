require 'bundler/gem_tasks'
require 'pathname'

task :default => [ :tests ]

desc 'Run all tests in path specified (defaults to tests). Tell Rake to start at a specific path with `rake tests[\'tests/lib/staticpress/content\']`'
task :tests, :path do |t, args|
  args.with_defaults(:path => 'tests')

  run_recursively = lambda do |dir|
    Pathname(dir).expand_path.children.each do |dir_or_test|
      if dir_or_test.directory?
        run_recursively.call dir_or_test
      elsif dir_or_test.to_s.end_with? '_test.rb'
        require_relative dir_or_test
      end
    end
  end

  run_recursively.call args[:path]
end

desc 'Enumerate annotations. Optionally takes a pipe-separated list of tags to process'
task :notes, :types do |t, args|
  args.with_defaults :types => 'FIXME|TODO'

  types = args[:types].split '|'
  finder = /.*# ?(?<type>[A-Z]+):? (?<note>.+)$/
  result = Hash.new { |hash, key| hash[key] = {} }

  `git ls-files`.split("\n").each do |p|
    path = Pathname(p)
    line_number = 0

    path.each_line do |line|
      line_number += 1

      if match = finder.match(line)
        result[path][line_number] = { :type => match[:type], :note => match[:note] } if types.include? match[:type]
      end
    end rescue nil
  end

  numbers = []

  result.each do |path, lines|
    lines.each do |number, note|
      numbers << number
    end
  end

  number_width = numbers.max.to_s.length
  type_width = types.max_by { |type| type.to_s.length }.to_s.length

  result.each do |path, lines|
    puts "\e[1m#{path}\e[0m:"

    lines.each do |number, note|
      line_number = "[\e[1m#{number.to_s.rjust(number_width)}\e[0m]"
      type = "[\e[0;37m#{note[:type]}\e[0m]"
      puts "  * #{line_number} #{type.ljust(type_width + type.length - note[:type].length)} #{note[:note]}"
    end

    puts
  end
end
