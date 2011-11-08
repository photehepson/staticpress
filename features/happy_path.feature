Feature: The happy path

  Scenario: Creating a new blog
    When I run `staticpress new my_new_blog`
    Then the exit status should be 0
    And the following files should exist:
      | my_new_blog/config.ru       |
      | my_new_blog/config.yml      |
      | my_new_blog/Gemfile         |
      | my_new_blog/README.markdown |

  Scenario: Creating a new blog with a custum title
    When I run `staticpress new my_new_blog 'This is my blog'`
    Then the file "my_new_blog/config.yml" should contain exactly:
      """
      ---
      :title: This is my blog

      """

  Scenario: Creating a new blog post
    Given a blog exists
    When I run `staticpress create 'Hello World'`
    Then the exit status should be 0
    And a directory named "content/_posts" should exist
    And a post named "hello-world" should exist

  Scenario: Creating a static page
    Given a blog exists
    When I run `staticpress create_page about`
    Then the exit status should be 0
    And a directory named "content" should exist
    And a file named "content/about.markdown" should exist

  Scenario: Copying a built-in plugin
    Given a blog exists
    When I run `staticpress fork_plugin blockquote`
    Then the exit status should be 0
    And a directory named "plugins" should exist
    And a file named "plugins/blockquote.rb" should exist

  Scenario: Copying and renaming a built-in plugin
    Given a blog exists
    When I run `staticpress fork_plugin blockquote pullquote`
    Then the exit status should be 0
    And a directory named "plugins" should exist
    And a file named "plugins/pullquote.rb" should exist
    And a file named "plugins/blockquote.rb" should not exist

  Scenario: Copying the default theme
    Given a blog exists
    When I run `staticpress fork_theme`
    Then the exit status should be 0
    And a directory named "themes" should exist
    And a directory named "themes/basic" should exist
