require 'fileutils'
require 'pathname'
require 'rack'
require 'thor'

require 'octopress'
require 'octopress/error'
require 'octopress/helpers'
require 'octopress/plugin'
require 'octopress/site'
require 'octopress/version'

module Octopress
  class CLI < Thor
    include Thor::Actions
    include Octopress::Helpers

    default_task :help

    desc 'help [task]', 'Describe available tasks or one specific task'
    def help(*args)
      general_usage = <<-USAGE
Usage:
  octopress <task> <required-argument> [option-argument]

      USAGE
      puts general_usage if args.empty?
      super
    end

    desc 'new <path-to-blog> [name-of-blog]', 'Creates a new blog in <path-to-blog>'
    long_desc <<-DESCRIPTION
<path-to-blog> will be created if it does not exist, and
files will be overwritten if they do exist
    DESCRIPTION
    def new(destination, name = nil)
      Octopress.blog_path = destination

      FileUtils.mkdir_p Octopress.blog_path
      FileUtils.cp_r((Octopress.root + 'skeleton').children, Octopress.blog_path)

      config.title = if name.to_s.empty?
        Octopress.blog_path.basename.to_s.split('_').map(&:capitalize).join(' ')
      else
        name
      end

      config.save
    end

    desc 'create <title>', 'Create a new blog post'
    def create(title)
      Octopress::Content::Post.create config.preferred_format, title
    end

    desc 'create_page <title> [path-in-content]', 'Create a new page in path-in-content'
    def create_page(title, path = nil)
      Octopress::Content::Page.create config.preferred_format, title, path
    end

    desc 'fork_plugin <plugin-name> [new-plugin-name]', 'Copies <plugin-name> into <path-to-blog>/plugins/'
    long_desc <<-DESCRIPTION
Copies <plugin-name> into <path-to-blog>/plugins/. If [new-plugin-name] is given, rename plugin
    DESCRIPTION
    def fork_plugin(name, new_name = nil)
      source = Octopress::Plugin.find name

      destination_name = new_name ? (new_name.end_with?('.rb') ? new_name : "#{new_name}.rb") : source.basename
      destination = Octopress.blog_path + (config.plugins_path || 'plugins') + destination_name

      FileUtils.mkdir_p destination.dirname
      FileUtils.cp source, destination
    end

    desc 'fork_theme [theme-name]', 'Copies [theme-name]\'s files into <path-to-blog>/themes/[theme-name] for customizations. If [theme-name] is blank, copies the currently configured theme'
    def fork_theme(name = nil)
      theme_name = name ? name : config.theme
      source = Octopress.root + 'themes' + theme_name
      destination = Octopress.blog_path + 'themes' + theme_name

      FileUtils.mkdir_p destination
      FileUtils.cp_r source.children, destination
    end

    desc 'build', 'Prepare blog for deployment'
    def build
      Octopress::Plugin.activate_enabled
      Octopress::Site.new.save
    end

    desc 'serve', 'Turn on local server for development'
    def serve
      Octopress::Plugin.activate_enabled
      Rack::Server.new(:config => (Octopress.blog_path + 'config.ru').to_s, :Port => config.port).start
    end

    desc 'push', 'Push blog to configured server'
    def push
    end

    desc 'deploy', 'Build blog and push in one step'
    def deploy
      build
      push
    end

    desc 'version', 'Display version'
    def version
      puts "Octopress #{Octopress::Version}"
    end
  end
end
