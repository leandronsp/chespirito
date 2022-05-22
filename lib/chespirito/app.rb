# frozen_string_literal: true

require_relative './request'

module Chespirito
  class App
    def initialize
      @routes = {}
    end

    def self.configure
      return unless block_given?

      new.tap { |app| yield(app) }
    end

    def register_route(verb, path, trait)
      @routes[route_key(verb, path)] = trait
    end

    def lookup(request)
      controller_klass, action = @routes[route_key(request.verb, request.path)]

      return unless controller_klass

      controller_klass.dispatch(action, request)
    end

    def route_key(verb, path) = "#{verb} #{path}"

    def call(env)
    request  = ::Chespirito::Request.build(env)
    response = lookup(request)

    [
      response.status,
      response.headers,
      [response.body]
    ]
    end
  end

  def self.application = App.new
end
