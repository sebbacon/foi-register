require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get requestors" do
    get :requestors
    assert_response :success
  end

end
