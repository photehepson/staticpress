require_relative 'base_test'

require 'staticpress/content/category'
require 'staticpress/route'

class ContentCategoryTest < ContentBaseTest
  def setup
    super

    @category_page_route = Staticpress::Route.from_url_path '/category/programming'
    @category_page = Staticpress::Content::Category.new @category_page_route, :markdown
  end

  def test__equalsequals
    assert_operator @category_page, :==, Staticpress::Content::Category.new(@category_page_route, :markdown)
    refute_operator @category_page, :==, nil
  end

  def test_exist?
    assert @category_page.exist?, '@category_page does not exist'
  end

  def test_find_by_route
    assert_equal @category_page, Staticpress::Content::Category.find_by_route(@category_page_route)
  end

  def test_inspect
    assert_equal '#<Staticpress::Content::Category url_path=/category/programming>', @category_page.inspect
  end

  def test_raw
    assert_equal '= partial :list_posts, :posts => page.sub_content', @category_page.raw
  end

  def test_route
    assert_equal '/category/programming', @category_page.route.url_path
  end
end
