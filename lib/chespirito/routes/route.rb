# frozen_string_literal: true

module Chespirito
  class Route
    attr_reader :verb, :path, :controller_klass, :action

    def initialize(*attrs)
      @verb, @path, @trait = attrs
      @controller_klass, @action = @trait
    end

    def key = "#{@verb} #{@path}"
  end

  class SystemRoute
    attr_reader :key, :controller_klass, :action

    def initialize(*attrs)
      @key, @trait = attrs
      @controller_klass, @action = @trait
    end
  end
end
