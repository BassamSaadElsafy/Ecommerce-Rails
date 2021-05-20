require 'test_helper'

class StoreOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_orders_index_url
    assert_response :success
  end
end
