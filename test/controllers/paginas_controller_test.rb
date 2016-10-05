require 'test_helper'

class PaginasControllerTest < ActionController::TestCase
  test "should get catalogo" do
    get :catalogo
    assert_response :success
  end

end
