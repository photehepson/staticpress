require_relative 'base_test'

require 'staticpress/content/page'
require 'staticpress/route'

class ContentPageTest < ContentBaseTest
  def setup
    super

    @page_route = Staticpress::Route.from_url_path '/about'
    @page = Staticpress::Content::Page.new @page_route, :markdown

    @second_page_route = Staticpress::Route.from_url_path '/contact'
    @second_page = Staticpress::Content::Page.new @second_page_route, :markdown
  end

  def test__equalsequals
    assert_operator @page, :==, Staticpress::Content::Page.new(@page_route, :markdown)
    refute_operator @page, :==, @second_page
    refute_operator @page, :==, nil
  end

  def test_exist?
    assert @page.exist?, '@page does not exist'
    assert @second_page.exist?, '@second_page does not exist'
  end

  def test_find_by_route
    assert_equal @page, Staticpress::Content::Page.find_by_route(@page_route)
    assert_nil Staticpress::Content::Page.find_by_route(Staticpress::Route.from_url_path('/i/dont/exist'))
  end

  def test_inspect
    assert_equal '#<Staticpress::Content::Page url_path=/about>', @page.inspect
  end

  def test_raw
    assert_equal 'in page', @page.raw
    assert_equal "in page\n\nin page", @second_page.raw
  end

  def test_route
    assert_equal '/about', @page.route.url_path
    assert_equal '/contact', @second_page.route.url_path
  end
end
