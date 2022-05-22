module Chespirito
  class ControllerTest < Test::Unit::TestCase
    class RequestMock
    end

    class ControllerMock < Chespirito::Controller
      def index
        response.status  = 200
        response.headers = { 'Content-Type' => 'text/html' }
        response.body    = '<h1>Hello</h1>'
      end

      def create = response.status = 204
    end

    def test_dispatch_index
      response = ControllerMock.dispatch(:index, RequestMock.new)

      assert_equal 200,              response.status
      assert_equal 'text/html',      response.headers['Content-Type']
      assert_equal '<h1>Hello</h1>', response.body
    end

    def test_dispatch_create
      response = ControllerMock.dispatch(:create, RequestMock.new)

      assert_equal 204, response.status
    end
  end
end
