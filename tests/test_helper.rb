$:.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'

require 'octopress'

class TestHelper < MiniTest::Unit::TestCase
  SAMPLE_SITES = (Octopress.root + '..' + 'tests' + 'sample_sites').expand_path
  TEST_BLOG = SAMPLE_SITES + 'test_blog'

  def teardown
    Octopress.blog_path = '.'
    test_blog_public = TEST_BLOG + 'public'
    FileUtils.rm_rf test_blog_public if test_blog_public.directory?
  end
end
