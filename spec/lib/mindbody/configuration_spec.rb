# frozen_string_literal: true
require "active_support/core_ext/object/blank"
require "spec_helper"

require "mindbody/configuration"

RSpec.describe Mindbody::Configuration do
  describe "#source_name" do
    it "is empty by default" do
      config = described_class.new

      expect(config.source_name).to be_blank
    end
  end

  describe "#source_name=" do
    it "sets the value of #source_name" do
      source_name = "test"
      config = described_class.new

      config.source_name = source_name

      expect(config.source_name).to eq source_name
    end
  end
end
