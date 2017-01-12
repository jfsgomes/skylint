# frozen_string_literal: true
require "spec_helper"

require "mindbody"

RSpec.describe Mindbody do
  describe ".configuration" do
    it "returns a Mindbody::Configuration object" do
      expect(Mindbody.configuration).to be_a ::Mindbody::Configuration
    end

    context "when it is called multiple times" do
      it "always returns the same object" do
        config = Mindbody.configuration
        times = rand(1..10)

        objects = Array.new(times).map{ Mindbody.configuration }.uniq

        expect(objects).to match_array [config]
      end
    end
  end

  describe ".configure" do
    context "when the source name is changed" do
      it "retains that change in the configuration" do
        source_name = "test"

        Mindbody.configure do |c|
          c.source_name = source_name
        end

        expect(Mindbody.configuration.source_name).to eq source_name
      end
    end
  end
end
