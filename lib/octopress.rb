require 'pathname'

module Octopress
  def self.blog_path
    Pathname.new('.').expand_path
  end

  def self.root
    Pathname.new File.expand_path('..', __FILE__)
  end
end
