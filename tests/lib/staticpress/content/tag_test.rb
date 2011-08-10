require_relative 'base_test'

require 'staticpress/content/tag'
require 'staticpress/route'

class ContentTagTest < ContentBaseTest
  def setup
    super

    @tag_page_route = Staticpress::Route.from_url_path '/tag/code'
    @tag_page = Staticpress::Content::Tag.new @tag_page_route, :markdown
  end

  def test__equalsequals
    assert_operator @tag_page, :==, Staticpress::Content::Tag.new(@tag_page_route, :markdown)
    refute_operator @tag_page, :==, nil
  end

  def test_exist?
    assert @tag_page.exist?, '@tag_page does not exist'
  end

  def test_find_by_route
    assert_equal @tag_page, Staticpress::Content::Tag.find_by_route(@tag_page_route)
  end

  def test_inspect
    assert_equal '#<Staticpress::Content::Tag url_path=/tag/code>', @tag_page.inspect
  end

  def test_raw
  end

  def test_route
    assert_equal '/tag/code', @tag_page.route.url_path
  end
end