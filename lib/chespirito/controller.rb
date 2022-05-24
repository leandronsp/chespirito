# frozen_string_literal: true

require_relative './response'

module Chespirito
  class Controller
    attr_reader :request, :response

    def initialize(request)
      @request  = request
      @response = ::Chespirito::Response.new
    end

    def self.process(action, request)
      new(request)
        .tap  { |controller| controller.send(action.to_sym) }
        .then { |controller| controller.response }
    end

    def view(path) = File.read(path)
  end
end
