require 'test_helper'
require 'webmock'
include WebMock::API
WebMock.enable!
 
class PageTest < ActionDispatch::IntegrationTest
  url = 'http://www.qwerty.com/'
  stub_request(:any, url).
    to_return(body: '<h1>Heading1</h1><h2>Heading2</h2><h3>Heading3</h3><a href="https://google.com">Google</a>')
  
  test 'Should get valid list of users' do
    get '/pages'
    assert_response :success
    assert_equal response.content_type, 'application/vnd.api+json'
    jdata = JSON.parse response.body
    assert_equal 2, jdata['data'].length
    assert_equal jdata['data'][0]['type'], 'pages'
  end

  test 'Creating new page with invalid type in JSON data should result in 400' do
    post '/pages', params: {data:{type:'posts'}},
      headers: ["'Content-Type': 'application/vnd.api+json'"]
    assert_response 400
  end

  test 'Creating new page with invalid URL should result in 422' do
    post '/pages', params: {data:{type:'pages',attributes:{'url':'qwerty'}}},
      headers: ["'Content-Type': 'application/vnd.api+json'"]
    assert_response 422
  end

  test 'Should scrape a valid URL' do
    post '/pages', params: {data:{type:'pages',attributes:{url:url}}},
      headers: ["'Content-Type': 'application/vnd.api+json'"]
    assert_response 201
    jdata = JSON.parse response.body
    assert_equal ['Heading1'], jdata['data']['attributes']['h1']
    assert_equal ['Heading2'], jdata['data']['attributes']['h2']
    assert_equal ['Heading3'], jdata['data']['attributes']['h3']
    assert_equal ['https://google.com'], jdata['data']['attributes']['links']
    assert_equal url, jdata['data']['attributes']['url']
  end
end