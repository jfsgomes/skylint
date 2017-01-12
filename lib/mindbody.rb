# frozen_string_literal: true
require "mindbody/configuration"

module Mindbody
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
