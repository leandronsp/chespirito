# frozen_string_literal: true

require_relative './route_utils'

module Chespirito
  class RouteConstraintChecker
    def initialize(request)
      @request = request
    end

    def match_route?(route)
      return false unless route.respond_to?(:path)
      return false if route_constraints(route).empty?

      route_constraints(route).size == request_constraints(route).size
    end

    def extract_params(route)
      return {} unless route.respond_to?(:path)
      return {} unless match_route?(route)

      route_constraints(route)
        .zip(request_constraints(route))
        .to_h
    end

    def route_constraints(route)   = RouteUtils.constraints(route.path)
    def request_constraints(route) = request_parts - route_parts(route)

    def route_parts(route) = RouteUtils.parts(route.path)
    def request_parts      = RouteUtils.words(@request.path)
  end
end
