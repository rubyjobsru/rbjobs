require "token_generator"
require "html_generator"

class Vacancy < ActiveRecord::Base
  attr_accessible :title, :description, :location, :company, :url, :name, :email, :phone, :expire_at
  
  validates :title, :description, :location, :expire_at, :presence => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :unless => Proc.new { |vacancy| vacancy.email.blank? } }
  
  before_create do |vacancy|
    vacancy.owner_token = TokenGenerator.generate_token
    vacancy.admin_token = TokenGenerator.generate_token
  end
  
  before_save do |vacancy|
    vacancy.excerpt_html     = HtmlGenerator.render extract_excerpt(vacancy.description)
    vacancy.description_html = HtmlGenerator.render vacancy.description
  end

  scope :approved, where("approved_at IS NOT NULL")
  scope :not_approved, where({ :approved_at => nil })
  scope :not_outdated, lambda { where("expire_at >= ?", Date.current) }
  scope :descent_order, order("id DESC")
  scope :available, approved.not_outdated.descent_order
  
  def approved?
    self.approved_at.present?
  end
  
  def approve!
    self.approved_at = Time.now and self.save!
  end
  
  def expired?
    self.expire_at.past?
  end
  
  protected
  
  # Take the first three parts of text
  def extract_excerpt(text, divider = "\r\n\r\n")
    text.lines(divider).to_a.each(&:strip!).reject(&:blank?).take(3).join(divider)
  end
end
