# frozen_string_literal: true

require 'test/unit'
require 'byebug'

Dir['./lib/**/*.rb'].sort.each { |file| require file }
Dir['./test/**/*.rb'].sort.each { |file| require file }
