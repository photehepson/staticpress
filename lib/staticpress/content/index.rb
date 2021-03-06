require 'staticpress'
require 'staticpress/content/base'
require 'staticpress/content/post'
require 'staticpress/content/collection_content'

module Staticpress::Content
  class Index < Base
    extend CollectionContent

    def optional_param_defaults
      { :number => pages_count }
    end

    def pages_count
      (self.class.all_posts.count / config.posts_per_page.to_f).ceil
    end

    def sub_content
      paginate(self.class.all_posts.sort)[params[:number] - 1]
    end

    def template_path
      self.class.template_path
    end

    def self.all
      reply = []

      1.upto paginate(all_posts).count do |number|
        reply << new(:number => number)
      end

      reply
    end

    def self.all_posts
      Staticpress::Content::Post.all
    end
  end
end
