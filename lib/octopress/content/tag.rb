require 'octopress'
require 'octopress/content/ethereal_content'
require 'octopress/route'

module Octopress::Content
  class Tag < EtherealContent
    def content
      { :text => '' }
    end

    def self.all
      []
    end
  end
end