# frozen_string_literal: true

class Event
  attr_accessor :code,
                :vacancy,
                :visitor

  def initialize
    yield(self) if block_given?
  end

  def created_at
    @created_at ||= DateTime.current
  end
end
