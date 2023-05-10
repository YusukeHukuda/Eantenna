require "test_helper"

class Public::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get public_comments_show_url
    assert_response :success
  end
end
