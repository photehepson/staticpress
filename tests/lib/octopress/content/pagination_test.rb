require_relative 'base_test'

require 'octopress/content/pagination'
require 'octopress/route'

class ContentPaginationTest < ContentBaseTest
  def setup
    super

    @page_one_route = Octopress::Route.from_url_path '/page/1'
    @page_one = Octopress::Content::Pagination.new @page_one_route, :markdown

    @page_two_route = Octopress::Route.from_url_path '/page/2'
    @page_two = Octopress::Content::Pagination.new @page_two_route, :markdown
  end

  def test__equalsequals
    assert_operator @page_one, :==, Octopress::Content::Pagination.new(@page_one_route, :markdown)
    refute_operator @page_one, :==, @page_two
    refute_operator @page_one, :==, nil
  end

  def test_exist?
    assert @page_one.exist?, '@page_one does not exist'
    assert @page_two.exist?, '@page_two does not exist'
  end

  def test_find_by_route
    assert_equal @page_one, Octopress::Content::Pagination.find_by_route(@page_one_route)
    assert_equal @page_two, Octopress::Content::Pagination.find_by_route(@page_two_route)
  end

  def test_inspect
    assert_equal '#<Octopress::Content::Pagination url_path=/page/1>', @page_one.inspect
  end

  def test_raw
  end

  def test_route
    assert_equal '/page/1', @page_one.route.url_path
    assert_equal '/page/2', @page_two.route.url_path
  end
end