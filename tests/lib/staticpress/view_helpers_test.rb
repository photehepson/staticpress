require_relative '../../test_helper'

require 'staticpress/view_helpers'

class ViewHelpersTest < TestHelper
  def setup
    Staticpress.blog_path = TEST_BLOG
    @post_route = Staticpress::Route.from_url_path '/2011/07/20/hello'
    @post = Staticpress::Content::Post.new @post_route, :markdown
    @view_helpers = Staticpress::ViewHelpers.new @post.theme
  end

  def test_partial_with_one_post
    expected = <<-HTML
<section>
  <article>#{@post.render_partial.strip}</article>
</section>
    HTML
    assert_equal expected, @view_helpers.partial(:list_posts, :posts => [ @post ])
  end

  def test_partial_with_no_posts
    expected = <<-HTML
<section>
</section>
    HTML
    assert_equal expected, @view_helpers.partial(:list_posts, :posts => [ ])
  end
end
