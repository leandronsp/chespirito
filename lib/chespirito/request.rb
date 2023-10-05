# frozen_string_literal: true

require 'rack'
require 'json'
require 'cgi'

module Chespirito
  class Request
    attr_reader :verb, :path, :headers, :params, :cookies

    def initialize(verb, path, headers: {}, params: {}, cookies: {})
      @verb = verb
      @path = path

      @headers = headers
      @params  = params
      @cookies = cookies
    end

    def self.build(env)
      rack_request = Rack::Request.new(env)

      body_params = rack_request.post? ? parse_body_params(rack_request.body.read, 
                                                           rack_request.env) : {}

      params = rack_request.params.merge(body_params)

      new(
        rack_request.request_method,
        rack_request.path,
        headers: rack_request.env,
        params: params,
        cookies: rack_request.cookies
      )
    end

    def self.parse_body_params(body_data, request_env)
      content_type = request_env['Content-Type'] || request_env['content-type']

      case content_type
      in 'application/json'; JSON.parse(body_data)
      in 'application/x-www-form-urlencoded'
        CGI.unescape(body_data).split('&').each_with_object({}) do |param, hash|
          key, value = param.split('=')
          hash[key] = value
        end
      else {}
      end
    end

    def add_param!(name, value)
      @params ||= {}

      @params[name] = value
    end
  end
end
