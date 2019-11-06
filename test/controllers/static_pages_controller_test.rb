require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get faq" do
    get static_pages_faq_url
    assert_response :success
  end

  test "should get guide" do
    get static_pages_guide_url
    assert_response :success
  end

end
