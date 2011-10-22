require 'staticpress'
require 'staticpress/content/base'
require 'staticpress/content/resource_content'
require 'staticpress/content/static_content'
require 'staticpress/route'

module Staticpress::Content
  class Page < Base
    include StaticContent
    extend ResourceContent

    def static?
      (Staticpress.blog_path + config.source + route.params[:slug]).file?
    end

    def self.all
      all_but_posts = if (posts_dir = Staticpress.blog_path + config.posts_source).directory?
        (Staticpress.blog_path + config.source).children - [ posts_dir ]
      else
        (Staticpress.blog_path + config.source).children
      end

      gather_resources_from all_but_posts
    end

    def self.create(format, title, path = nil)
      name = title.gsub(/ /, '-').downcase

      filename = "#{name}.#{format}"
      destination = Staticpress.blog_path + config.source + (path ? path : '').sub(/^\//, '') + filename

      FileUtils.mkdir_p destination.dirname
      destination.open('w') { |f| f.write template }
    end

    def self.find_by_path(path)
      if path.file?
        path_string = path.to_s

        slug = if supported_extensions.any? { |ext| path_string.end_with? ext.to_s }
          extensionless_path(path).to_s
        else
          path_string
        end.sub((Staticpress.blog_path + config.source).to_s, '').sub(/^\//, '')

        params = {
          :content_type => self,
          :slug => slug
        }

        find_by_route Staticpress::Route.new(params)
      end
    end

    def self.find_by_route(route)
      return nil unless route

      base = Staticpress.blog_path + config.source
      path = base + route.params[:slug]
      return new(route, path) if path.file?

      catch :page do
        supported_extensions.each do |extension|
          path = base + "#{route.params[:slug]}.#{extension}"
          throw :page, new(route, path) if path.file?
        end

        nil
      end
    end

    def self.template
      <<-TEMPLATE
in page
      TEMPLATE
    end
  end
end
