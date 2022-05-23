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
  end
end
