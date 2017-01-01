xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.jobs do
  vacancies.each do |vacancy|
    xml.job id: vacancy.id do
      xml.link vacancy_url(vacancy)
      xml.name vacancy.title
      xml.region company_location_tag(vacancy)
      xml.description vacancy.description_html
      xml.pubdate vacancy.created_at.iso8610
      xml.updated vacancy.updated_at.iso8610
      xml.salary salary_range(vacancy)
      xml.company vacancy.company
      xml.expire vacancy.expire_at.iso8610
      xml.jobtype vacancy.employment_type
    end
  end
end
