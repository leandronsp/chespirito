# frozen_string_literal: true

module Chespirito
  class RouteUtils
    class << self
      def words(path)        = path.split("/").delete_if(&:empty?)
      def constraints(path)  = words(path).select(&method(:constraint?)).map(&method(:remove_colon))
      def parts(path)        = words(path).select(&method(:part?))
      def part?(word)        = !constraint?(word)
      def constraint?(word)  = word.start_with?(":")
      def remove_colon(word) = word.gsub(":", '')
    end
  end
end
