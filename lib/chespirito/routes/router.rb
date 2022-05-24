# frozen_string_literal: true

require_relative './route'
require_relative './route_constraint_checker'
require_relative '../response'

module Chespirito
  class Router
    def initialize
      @routes = {}
    end

    def register_route(*attrs)
      route = Route.new(*attrs)

      @routes[route.key] = route
    end

    def register_system_route(*attrs)
      route = SystemRoute.new(*attrs)

      @routes[route.key] = route
    end

    def dispatch(request)
      route = route_for(request)
      return not_found_response unless route

      route
        .controller_klass
        .process(route.action, request)
    end

    def route_for(request)
      simple_route(request) || constraint_route(request) || not_found_route
    end

    def simple_route(request)
      @routes["#{request.verb} #{request.path}"]
    end

    def constraint_route(request)
      constraint_checker = RouteConstraintChecker.new(request)

      route = @routes.values.find(&constraint_checker.method(:match_route?))
      return unless route

      route.tap do
        constraint_checker
          .extract_params(route)
          .each { |(name, value)| request.add_param!(name, value) }
      end
    end

    def not_found_route = @routes['404'] || @routes[:not_found]

    def not_found_response
      ::Chespirito::Response.new.tap do |response|
        response.status  = 404
        response.headers = {}
        response.body    = ''
      end
    end
  end
end
