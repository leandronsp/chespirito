# frozen_string_literal: true

require_relative './request'
require_relative './router'

module Chespirito
  class App
    def initialize
      @router = ::Chespirito::Router.new
    end

    def self.configure
      return unless block_given?

      new.tap { |app| yield(app) }
    end

    def register_route(*attrs)
      attrs => [verb, path, trait]

      @router.register_route(verb, path, trait)
    end

    def lookup(request) = @router.lookup(request)

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
