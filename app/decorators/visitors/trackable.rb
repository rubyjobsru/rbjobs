# frozen_string_literal: true

module Visitors
  class Trackable < SimpleDelegator
    def traits
      @traits ||= { id: id }
    end
  end
end
