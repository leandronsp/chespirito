require 'stringio'

module Chespirito
  class RequestTest < Test::Unit::TestCase
    def test_request_build
      headers = { 'Location' => 'http://localhost:3000/login' }

      env = {
        'REQUEST_METHOD' => 'GET',
        'PATH_INFO' => '/users',
        'QUERY_STRING' => 'active=true',
        'SERVER_PORT' => 3000,
        'SERVER_NAME' => 'localhost:3000',
        'CONTENT_LENGTH' => 412,
        'HTTP_COOKIE' => 'email=test@example.com',
        'rack.input' => ''
      }.merge(headers)

      request = ::Chespirito::Request.build(env)

      assert_equal 'GET',    request.verb
      assert_equal '/users', request.path
      assert_equal 'true',   request.params['active']

      assert_equal 'test@example.com',            request.cookies['email']
      assert_equal 'http://localhost:3000/login', request.headers['Location']
    end

    def test_request_restful
      env = {
        'REQUEST_METHOD' => 'GET',
        'PATH_INFO' => '/users/:id',
        'QUERY_STRING' => '',
        'SERVER_PORT' => 3000,
        'SERVER_NAME' => 'localhost:3000',
        'CONTENT_LENGTH' => 412,
        'HTTP_COOKIE' => 'email=test@example.com',
        'rack.input' => ''
      }.merge({})

      request = ::Chespirito::Request.build(env)

      assert_equal 'GET',        request.verb
      assert_equal '/users/:id', request.path

      assert request.params == {}
    end

    def test_request_restful_post
      env = {
        'REQUEST_METHOD' => 'POST',
        'PATH_INFO' => '/login',
        'QUERY_STRING' => '',
        'SERVER_PORT' => 3000,
        'SERVER_NAME' => 'localhost:3000',
        'CONTENT_LENGTH' => 412,
        'HTTP_COOKIE' => '',
        'rack.input' => StringIO.new('email=user%40example.com&password=pa%24%24w0rd')
      }.merge({ 'Content-Type' => 'application/x-www-form-urlencoded' })

      request = ::Chespirito::Request.build(env)

      assert_equal 'POST',   request.verb
      assert_equal '/login', request.path

      assert_equal request.params, { 'email' => 'user@example.com', 'password' => 'pa$$w0rd' }
    end

    def test_request_restful_post_json
      env = {
        'REQUEST_METHOD' => 'POST',
        'PATH_INFO' => '/login',
        'QUERY_STRING' => '',
        'SERVER_PORT' => 3000,
        'SERVER_NAME' => 'localhost:3000',
        'CONTENT_LENGTH' => 412,
        'HTTP_COOKIE' => '',
        'rack.input' => StringIO.new('{"username":"leandro"}')
      }.merge({ 'content-type' => 'application/json' })

      request = ::Chespirito::Request.build(env)

      assert_equal 'POST',   request.verb
      assert_equal '/login', request.path

      assert_equal request.params, { 'username' => 'leandro' }
    end
  end
end
