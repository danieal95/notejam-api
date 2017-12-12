require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  test 'note can be successfully created' do
    json_string = {:note => {:pad_id => 1, :user_id => 1, :name => "test_note", :text => "test_note"}}
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    post '/notes/create', params: json_string.to_json, headers: headers, headers: headers2
    assert_response 200
  end

  test "note can't be created if required fields are missing" do
    json_string = {:note => {:pad_id => 1, :user_id => 1, :name => "", :text => ""}}
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    post '/notes/create', params: json_string.to_json, headers: headers, headers: headers2
    assert_response 400
  end

  test "note can't be edited if required fields are missing" do
    json_string = {:note => {:pad_id => 1, :user_id => 1, :name => "", :text => ""}}
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    put '/notes/1', params: json_string.to_json, headers: headers, headers: headers2
    assert_response 400
  end

  test "note can be successfully deleted" do
    headers = { "CONTENT_TYPE" => "application/json" }
    headers2 = { 'Accept' => 'application/json' }
    delete '/notes/1', headers: headers, headers: headers2
    assert_response 200
  end
end
