# frozen_string_literal: true
class Vacancy < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :email, presence: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    unless: proc { |vacancy| vacancy.email.blank? }
  }
  validates :expire_at, presence: true

  scope :approved, -> { where('approved_at IS NOT NULL') }
  scope :not_approved, -> { where(approved_at: nil) }
  scope :not_outdated, ->(date) { where('expire_at >= ?', date) }
  scope :descent_order, -> { order('id DESC') }
  scope :available, -> { approved.not_outdated(Date.current).descent_order }

  def approve!
    return if approved?
    update!(approved_at: Time.current)
  end

  def refuse!
    return unless approved?
    update!(approved_at: nil)
  end

  def approved?
    approved_at.present?
  end

  def expired?
    expire_at.past?
  end
end
