# frozen_string_literal: true
module HtmlGenerator
  def self.render(source, strategy = Markdown.new)
    strategy.render(source)
  end

  class Markdown
    delegate :render, to: :markdown

    private

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, autolink: false)
    end

    def renderer
      @renderer ||= Redcarpet::Render::HTML.new(hard_wrap: true,
                                                filter_html: true,
                                                no_images: true,
                                                no_links: false,
                                                safe_links_only: true,
                                                no_styles: true)
    end
  end
end
