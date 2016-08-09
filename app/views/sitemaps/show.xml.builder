xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc root_url
    xml.priority 0.8
    xml.changefreq 'weekly'
  end

  xml.url do
    xml.loc vacancies_url
    xml.priority 0.8
    xml.changefreq 'weekly'
  end

  %i(about terms contacts).each do |page|
    xml.url do
      xml.loc page_url(page)
      xml.priority 0.3
    end
  end
end
