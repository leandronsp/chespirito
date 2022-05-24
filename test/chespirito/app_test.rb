module Chespirito
  class AppTest < Test::Unit::TestCase
    class RequestMock < Chespirito::Request
      def initialize; end
      def verb = 'GET'
      def path = '/'
    end

    class NotFoundRequestMock < Chespirito::Request
      def initialize; end
      def verb = 'GET'
      def path = '/asdf'
    end

    class RequestMockRestful < Chespirito::Request
      attr_accessor :path

      def initialize; end
      def verb = 'GET'
    end

    class ControllerMock < Chespirito::Controller
      def test
        response.status  = 200
        response.headers = { 'Content-Type' => 'text/html' }
        response.body    = '<h1>Hello</h1>'
      end
    end

    class NotFoundControllerMock < Chespirito::Controller
      def show
        response.status  = 404
        response.headers = { 'Content-Type' => 'text/html' }
        response.body    = '<h1>Not Found!</h1>'
      end
    end

    class ControllerMockRestful < Chespirito::Controller
      def test
        response.status  = 200
        response.headers = { 'Content-Type' => 'text/html' }
        response.body    = "Params: #{request.params.keys.join(', ')} \
and values #{request.params.values.join(', ')}"
      end
    end

    def test_registering_app
      chespirito = Chespirito::App.configure do |app|
        app.register_route('GET', '/', [ControllerMock, :test])
      end

      response = chespirito.dispatch(RequestMock.new)

      assert_equal 200,              response.status
      assert_equal 'text/html',      response.headers['Content-Type']
      assert_equal '<h1>Hello</h1>', response.body
    end

    def test_request_not_found_with_default_response
      chespirito = Chespirito::App.configure do |app|
        app.register_route('GET', '/', [ControllerMock, :test])
      end

      response = chespirito.dispatch(NotFoundRequestMock.new)

      assert_equal 404, response.status
    end

    def test_request_not_found_with_system_route
      chespirito = Chespirito::App.configure do |app|
        app.register_route('GET', '/', [ControllerMock, :test])
        app.register_system_route(:not_found, [NotFoundControllerMock, :show])
      end

      response = chespirito.dispatch(NotFoundRequestMock.new)

      assert_equal 404, response.status
      assert_equal 'text/html',      response.headers['Content-Type']
      assert_equal '<h1>Not Found!</h1>', response.body
    end

    def test_request_route_with_constraints
      chespirito = Chespirito::App.configure do |app|
        app.register_route('GET', '/users/:id', [ControllerMockRestful, :test])
      end

      request = RequestMockRestful.new
      request.path = '/users/42'

      response = chespirito.dispatch(request)

      assert_equal 200,         response.status
      assert_equal 'text/html', response.headers['Content-Type']

      assert_equal 'Params: id and values 42', response.body
    end

    def test_request_complex_route
      chespirito = Chespirito::App.configure do |app|
        app.register_route('GET', '/users/:id/groups/:name/report', [ControllerMockRestful, :test])
      end

      request = RequestMockRestful.new
      request.path = '/users/42/groups/java/report'

      response = chespirito.dispatch(request)

      assert_equal 200,         response.status
      assert_equal 'text/html', response.headers['Content-Type']

      assert_equal 'Params: id, name and values 42, java', response.body
    end
  end
end
