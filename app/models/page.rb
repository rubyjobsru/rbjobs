# frozen_string_literal: true
require 'html_generator'

class Page
  attr_reader :id

  def initialize(id = nil)
    @id = id
  end

  def self.find_by_id(id)
    exists?(id) ? new(id) : nil
  end

  def self.exists?(id)
    ids.include?(id.to_s)
  end

  def self.ids
    %w(about terms contacts)
  end

  def persisted?
    false
  end

  def title
    get_field(id, :title)
  end

  def body_markdown
    get_field(id, :body)
  end

  def body_html
    HtmlGenerator.render(body_markdown)
  end

  private

  def get_field(id, field)
    I18n.translate(i18n_key_for_field(id, field))
  end

  def i18n_key_for_field(id, field)
    "pages.show.#{id}.#{field}"
  end
end
