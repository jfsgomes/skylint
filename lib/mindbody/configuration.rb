# frozen_string_literal: true
module Mindbody
  class Configuration
    attr_accessor :source_name, :source_password, :site_ids

    def initialize
      @site_ids = []
    end
  end
end
