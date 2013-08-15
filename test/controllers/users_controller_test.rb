require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "#new works" do
    get :new

    assert_response :ok
  end

  test "/new route exists" do
    assert_generates '/users/new', controller: 'users', action: 'new'
  end

  test "#create works with valid attributes" do
    attributes = valid_user_attributes

    assert_difference "User.count" do
      post :create, user: attributes
    end
  end

  test "#create fails gracefully with invalid attributes" do
    attributes = invalid_user_attributes

    assert_difference "User.count", 0 do
      post :create, user: attributes
    end

    assert_template :new
  end

  def valid_user_attributes
    user = users(:nick)
    attributes = user.attributes.except("id")
    attributes[:password] = "foo"
    attributes[:password_confirmation] = "foo"
    user.destroy!

    raise unless User.new(attributes).valid?

    return attributes
  end

  def invalid_user_attributes
    attributes = valid_user_attributes
    attributes[:username] = nil

    raise if User.new(attributes).valid?

    return attributes
  end

  test "should send an e-mail when user registers" do

    ActionMailer::Base.deliveries.clear

    assert_difference 'ActionMailer::Base.deliveries.size' do
      post :create, user: { username: "ron", email: 'ron@ron.com', password: "password", password_confirmation: "password" }
    end

    confirm_email = ActionMailer::Base.deliveries.last
 
    assert_equal 'Confirm your e-mail for Lovely Flickr', confirm_email.subject
    assert_equal "ron@ron.com", confirm_email.to[0]
  end

end
