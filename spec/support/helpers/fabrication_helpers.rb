# frozen_string_literal: true

module FabricationHelpers
  delegate :build, :create, :attributes_for, to: Fabricate
end
