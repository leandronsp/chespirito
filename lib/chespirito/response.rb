# frozen_string_literal: true

module Chespirito
  class Response
    attr_accessor :status, :headers, :body

    def initialize
      @status  = nil
      @headers = {}
      @body    = ''
    end
  end
end
