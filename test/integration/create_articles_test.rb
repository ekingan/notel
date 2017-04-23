require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Kingan", email: "kingan@gmail.com", password: "password", admin: true)
    @article = Article.create(title: "Title", description: "description")
  end

  test "get new article form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "Title", description: "description"}
    end
    assert_template 'articles/show'
    assert_match "Title", response.body
    assert_match "description", response.body
  end

  test "invalid article title results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: " "}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "invalid article description results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {description: " "}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end


end
