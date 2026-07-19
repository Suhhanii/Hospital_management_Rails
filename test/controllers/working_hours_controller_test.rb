require "test_helper"

class WorkingHoursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get working_hours_index_url
    assert_response :success
  end

  test "should get edit" do
    get working_hours_edit_url
    assert_response :success
  end
end
