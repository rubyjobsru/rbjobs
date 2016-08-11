# frozen_string_literal: true
require 'securerandom'

FactoryGirl.define do
  sequence :title do |n|
    SecureRandom.base64(n + 10)
  end

  sequence :description do |n|
    SecureRandom.base64(n + 10)
  end

  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :location do |n|
    SecureRandom.base64(n + 10)
  end

  factory :vacancy do
    title { generate(:title) }
    description { generate(:description) }
    location { generate(:location) }
    email { generate(:email) }
    expire_at 1.week.from_now
  end

  factory :approved_vacancy, parent: :vacancy do
    approved_at Time.current
  end

  factory :disapproved_vacancy, parent: :vacancy do
    approved_at nil
  end

  factory :archived_vacancy, parent: :approved_vacancy do
    expire_at 1.day.ago
  end
end
