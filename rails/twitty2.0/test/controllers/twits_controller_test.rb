require 'test_helper'

class TwitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twit = twits(:one)
  end

  test "should get index" do
    get twits_url
    assert_response :success
  end

  test "should get new" do
    get new_twit_url
    assert_response :success
  end

  test "should create twit" do
    assert_difference('Twit.count') do
      post twits_url, params: { twit: { content: @twit.content, user_id: @twit.user_id } }
    end

    assert_redirected_to twit_url(Twit.last)
  end

  test "should show twit" do
    get twit_url(@twit)
    assert_response :success
  end

  test "should get edit" do
    get edit_twit_url(@twit)
    assert_response :success
  end

  test "should update twit" do
    patch twit_url(@twit), params: { twit: { content: @twit.content, user_id: @twit.user_id } }
    assert_redirected_to twit_url(@twit)
  end

  test "should destroy twit" do
    assert_difference('Twit.count', -1) do
      delete twit_url(@twit)
    end

    assert_redirected_to twits_url
  end
end
