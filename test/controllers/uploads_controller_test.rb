require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get format" do
    get :format
    assert_response :success
  end

end
