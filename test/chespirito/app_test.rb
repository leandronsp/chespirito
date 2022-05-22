module Chespirito
  class AppTest < Test::Unit::TestCase
    class RequestMock
      def verb = 'GET'
      def path = '/'
    end

    class ControllerMock < Chespirito::Controller
      def test
        response.status  = 200
        response.headers = { 'Content-Type' => 'text/html' }
        response.body    = '<h1>Hello</h1>'
      end
    end

    def test_registering_app
      chespirito = Chespirito::App.configure do |app|
        app.register_route('GET', '/', [ControllerMock, :test])
      end

      response = chespirito.lookup(RequestMock.new)

      assert_equal 200,              response.status
      assert_equal 'text/html',      response.headers['Content-Type']
      assert_equal '<h1>Hello</h1>', response.body
    end
  end
end
