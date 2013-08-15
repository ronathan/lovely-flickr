require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

	test "should only be able to comment if logged in" do
    session[:user_id] = nil
    post :create, comment: { body: "Some valid content" }
    assert_redirected_to new_session_path
  end

  test "should be able to create a comment if logged in" do
    skip
    login_as(:nick)
    session[:photo_id] = photos(:one).id
    assert_difference('Comment.count') do
      post :create, comment: { body: "Some valid content" }
    end
  end

end
	