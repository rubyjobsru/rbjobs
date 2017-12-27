# frozen_string_literal: true

require 'html_generator'

class Page
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def self.find(id)
    I18n.exists?("pages.show.#{id}") ? new(id) : nil
  end

  def title
    @title ||= I18n.translate(:title, scope: i18n_scope)
  end

  def body
    @body ||= HtmlGenerator.render(raw_body)
  end

  private

  def i18n_scope
    @i18n_scope ||= "pages.show.#{id}"
  end

  def raw_body
    @raw_body ||= I18n.translate(:body, scope: i18n_scope)
  end
end
