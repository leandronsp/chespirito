# frozen_string_literal: true

require_relative './request'
require_relative './response'

module Chespirito
  class Router
    def initialize
      @routes = {}
    end

    def register_route(verb, path, trait)
      @routes[route_key(verb, path)] = trait
    end

    def lookup(request)
      controller_klass, action = @routes[route_key(request.verb, request.path)]

      return not_found_response unless controller_klass

      controller_klass.dispatch(action, request)
    end

    def route_key(verb, path) = "#{verb} #{path}"

    def not_found_response
      ::Chespirito::Response.new.tap do |response|
        response.status  = 404
        response.headers = {}
        response.body    = ''
      end
    end
  end
end
