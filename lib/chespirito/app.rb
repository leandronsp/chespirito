# frozen_string_literal: true

require_relative './request'
require_relative './routes/router'

module Chespirito
  class App
    def initialize
      @router = ::Chespirito::Router.new
    end

    def self.configure
      return unless block_given?

      new.tap { |app| yield(app) }
    end

    def register_route(verb, path, trait)
      @router.register_route(verb, path, trait)
    end

    def register_system_route(key, trait)
      @router.register_system_route(key, trait)
    end

    def dispatch(request) = @router.dispatch(request)

    def call(env)
      request  = ::Chespirito::Request.build(env)
      response = dispatch(request)

      [
        response.status,
        response.headers,
        [response.body]
      ]
    end
  end

  def self.application = App.new
end
