# frozen_string_literal: true

Fabricator(:vacancy) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph(5) }
  location { Faker::Address.city }
  company { Faker::Company.name }
  email { Faker::Internet.email }
  expire_at { 1.week.from_now }
end

Fabricator(:approved_vacancy, from: :vacancy) do
  approved_at { Time.current }
end

Fabricator(:disapproved_vacancy, from: :vacancy) do
  approved_at nil
end

Fabricator(:archived_vacancy, from: :approved_vacancy) do
  expire_at { 1.day.ago }
end
