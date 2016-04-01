require "html_generator"

class Page
  attr_reader :id

  def initialize(id = nil)
    @id = id
  end

  def self.find_by_id(id)
    return self.exists?(id) ? self.new(id) : nil
  end

  def self.exists?(id)
    self.ids.include?(id.to_s)
  end

  def self.ids
    ["about", "terms", "contacts"]
  end

  def persisted?
    false
  end

  def title
    Page.get_field(self.id, :title)
  end

  def body_markdown
    Page.get_field(self.id, :body)
  end

  def body_html
    HtmlGenerator.render(self.body_markdown)
  end

  private

  def self.i18n_key_for_field(id, field)
    "pages.show.#{id}.#{field}"
  end

  def self.get_field(id, field)
    I18n.translate i18n_key_for_field(id, field)
  end
end
