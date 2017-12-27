# frozen_string_literal: true
require 'securerandom'

class Visitor
  STORE_FIELD = :visitor_id

  attr_reader :id

  def initialize(id = nil)
    @id = id
  end

  class << self
    attr_writer :store

    def find_or_create
      id = fetch_id || create_id
      new(id)
    end

    private

    def fetch_id
      store[STORE_FIELD]
    end

    def create_id
      store[STORE_FIELD] = SecureRandom.uuid
    end

    def store
      @store ||= {}
    end
  end
end
