require_relative '../../test_helper'

require 'fileutils'
require 'pathname'

require 'octopress/cli'
require 'octopress/helpers'

class CLITest < TestHelper
  include Octopress::Helpers

  TEMP_BLOG = SAMPLE_SITES + 'temp_blog'

  def setup
    Octopress.blog_path = TEMP_BLOG
    @cli = Octopress::CLI.new
  end

  def teardown
    FileUtils.rm_rf TEMP_BLOG if TEMP_BLOG.directory?
    super
  end

  def test_help
  end

  def test_new
    refute TEMP_BLOG.directory?
    @cli.new TEMP_BLOG
    assert_equal 5, TEMP_BLOG.children.count
    assert_equal 'Temp Blog', config.title
  end

  def test_new_with_custom_title
    @cli.new TEMP_BLOG, 'This is my blog'
    assert_equal 'This is my blog', config.title
  end

  def test_create
  end

  def test_create_page
  end

  def test_fork_plugin
  end

  def test_fork_theme
  end

  def test_build
  end

  def test_serve
  end

  def test_push
  end

  def test_deploy
  end

  def test_version
  end
end
