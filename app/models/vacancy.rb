# frozen_string_literal: true
class Vacancy < ActiveRecord::Base
  CURRENCY_RUB = 'RUB'
  CURRENCY_EUR = 'EUR'
  CURRENCY_USD = 'USD'

  CURRENCIES = [
    CURRENCY_RUB,
    CURRENCY_EUR,
    CURRENCY_USD
  ].freeze

  SALARY_UNIT_HOUR    = 'hour'
  SALARY_UNIT_MONTH   = 'month'
  SALARY_UNIT_YEAR    = 'year'
  SALARY_UNIT_PROJECT = 'project'

  SALARY_UNITS = [
    SALARY_UNIT_HOUR,
    SALARY_UNIT_MONTH,
    SALARY_UNIT_YEAR,
    SALARY_UNIT_PROJECT
  ].freeze

  EMPLOYMENT_TYPE_FULLTIME   = 'full-time'
  EMPLOYMENT_TYPE_PARTTIME   = 'part-time'
  EMPLOYMENT_TYPE_CONTRACT   = 'contract'
  EMPLOYMENT_TYPE_TEMPORARY  = 'temporary'
  EMPLOYMENT_TYPE_INTERNSHIP = 'internship'
  EMPLOYMENT_TYPE_OTHER      = 'other'

  EMPLOYMENT_TYPES = [
    EMPLOYMENT_TYPE_FULLTIME,
    EMPLOYMENT_TYPE_PARTTIME,
    EMPLOYMENT_TYPE_CONTRACT,
    EMPLOYMENT_TYPE_TEMPORARY,
    EMPLOYMENT_TYPE_INTERNSHIP,
    EMPLOYMENT_TYPE_OTHER
  ].freeze

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true, unless: :remote_position?
  validates :email, presence: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    unless: proc { |vacancy| vacancy.email.blank? }
  }
  validates :expire_at, presence: true
  validates :salary_min, numericality: {
    greater_than_or_equal_to: 0.0,
    allow_nil: true
  }
  validates :salary_max, numericality: {
    greater_than_or_equal_to: 0.0,
    allow_nil: true
  }
  validates :salary_currency, inclusion: {
    in: CURRENCIES,
    allow_blank: true
  }
  validates :salary_unit, inclusion: {
    in: SALARY_UNITS,
    allow_blank: true
  }
  validates :employment_type, inclusion: {
    in: EMPLOYMENT_TYPES,
    allow_blank: true
  }

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

  def remote_position?
    remote_position
  end
end
