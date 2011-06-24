require 'fileutils'
require 'pathname'

require 'octopress'

module Octopress
  class CLI
    def help
      puts <<-MESSAGE
Help message goes here
      MESSAGE
    end

    def new(destination, name)
      dest = Pathname.new(destination).expand_path

      blog_name = if name.to_s.empty?
        dest.basename.to_s.split('_').map(&:capitalize).join(' ')
      else
        name
      end

      FileUtils.cp_r((Octopress.root + 'skeleton').children, dest)
    end

    def fork_plugin
    end

    def fork_theme
    end

    def serve
    end

    def package
    end

    def deploy
    end

    def version
    end

    def self.run
      cli = new
      command = (ARGV.first || :help).to_sym

      case command
      when :new
        cli.new ARGV[1], ARGV[2]
      when :fork_plugin, :fork_theme
        cli.send command, ARGV[1]
      when :serve, :package, :deploy, :version
        cli.send command
      else
        cli.help
      end
    end

    protected

    def blog_path
      Pathname.new('.').expand_path
    end
  end
end