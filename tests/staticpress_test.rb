require_relative 'test_case'

require 'pathname'

class StaticpressTest < TestCase
  def test_blog_path
    assert_equal Pathname.new('tests/sample_sites/test_blog').expand_path, Staticpress.blog_path
  end

  def test_blog_path=
    Staticpress.blog_path = 'some/other/directory'
    assert_equal Pathname.new('some/other/directory').expand_path, Staticpress.blog_path
  end

  def test_root
    assert_equal Pathname.new('lib/').expand_path, Staticpress.root
  end
end