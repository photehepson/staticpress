require 'octopress'
require 'octopress/configuration'

module Octopress
  module Helpers
    def config
      Octopress::Configuration.instance
    end

    def extensionless_basename(pathname)
      path = pathname.basename.to_path
      path[0...(path.length - pathname.extname.length)]
    end

    def route_options(title)
      t = Time.now.utc

      {
        :date => "#{t.year}-#{'%02d' % t.month}-#{'%02d' % t.day}",
        :year => t.year,
        :month => '%02d' % t.month,
        :day => '%02d' % t.day,
        :title => title
      }
    end
  end
end
