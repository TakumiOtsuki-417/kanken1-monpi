require 'test_helper'

class HelpsControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get helps_welcome_url
    assert_response :success
  end

end
