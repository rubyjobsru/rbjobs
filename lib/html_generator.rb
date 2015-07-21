module HtmlGenerator
  def self.render(source, strategy = Markdown.new)
    strategy.render(source)
  end

  class Markdown
    @@renderer = Redcarpet::Render::HTML.new(:hard_wrap => true, :filter_html => true, :no_images => true,
                                             :no_links => false, :safe_links_only => true, :no_styles => true)
    @@markdown = Redcarpet::Markdown.new(@@renderer, :autolink => false)

    def render(source)
      @@markdown.render(source)
    end
  end
end
