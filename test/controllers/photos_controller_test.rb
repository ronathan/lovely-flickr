require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "cannot access photos index if not logged in" do
    get :index
    assert_redirected_to new_session_path
  end

  test "new shows photo upload form" do
    login_as(:nick)
    get :new
    assert_response :ok
  end

  test "create should create a photo record in the db" do
    login_as(:nick)

    assert_difference "Photo.count" do
      post :create, photo: {title: "foo", description: "bar"}
    end

    photo = assigns(:photo)
    assert photo.user
    assert_redirected_to photo_path(assigns(:photo))
  end

  test "show should find a photo and render some HTML" do
    get :show, id: photos(:one).id
    assert_response :success
    assert assigns(:photo)
  end

  test "should get search method" do
    query_terms = "nice title"

    photo = photos(:one)
    photo.title = query_terms
    photo.save

    Photo.expects(:search_for).with(query_terms)

    post :search, query: query_terms
  end
end
