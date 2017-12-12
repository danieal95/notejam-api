require 'test_helper'

class PadsControllerTest < ActionDispatch::IntegrationTest
  test 'pad can be successfully created' do
    json_string = {:pad => {:user_id => 1, :name => "test_pad"}}
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    post '/pads/create', params: json_string.to_json, headers: headers, headers: headers2
    assert_response 200
  end

  test "pad can't be created if required fields are missing" do
    json_string = {:pad => {:user_id => 1, :name => ""}}
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    post '/pads/create', params: json_string.to_json, headers: headers, headers: headers2
    assert_response 400
  end

  test "pad can't be edited if required fields are missing" do
    json_string = {:pad => {:user_id => 1, :name => ""}}
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    put '/pads/1', params: json_string.to_json, headers: headers, headers: headers2
    assert_response 400
  end

  test "pad can be successfully deleted" do
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    delete '/pads/1', headers: headers, headers: headers2
    assert_response 200
  end

end
