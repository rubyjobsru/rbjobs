xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.jobs do
  feed_vacancies.each do |vacancy|
    xml.job id: vacancy.id do
      xml.link { xml.cdata! vacancy_url(vacancy) }
      xml.name { xml.cdata! vacancy.title }
      xml.region { xml.cdata! company_location_tag(vacancy) }
      xml.description { xml.cdata! vacancy.description_html }
      xml.pubdate { xml.cdata! vacancy.created_at.iso8601 }
      xml.updated { xml.cdata! vacancy.updated_at.iso8601 }
      xml.salary { xml.cdata! salary_with_units(vacancy) }
      xml.company { xml.cdata! vacancy.company }
      xml.expire { xml.cdata! vacancy.expire_at.iso8601 }
      xml.jobtype { xml.cdata! t("vacancies.employment_types.#{vacancy.employment_type}") }
    end
  end
end
