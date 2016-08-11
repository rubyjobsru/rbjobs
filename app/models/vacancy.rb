class Vacancy < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  validates :location, :presence => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :unless => Proc.new { |vacancy| vacancy.email.blank? } }
  validates :expire_at, :presence => true

  scope :approved, lambda { where("approved_at IS NOT NULL") }
  scope :not_approved, lambda { where({ :approved_at => nil }) }
  scope :not_outdated, lambda { |date| where("expire_at >= ?", date) }
  scope :descent_order, lambda { order("id DESC") }
  scope :available, lambda { approved.not_outdated(Date.current).descent_order }

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
