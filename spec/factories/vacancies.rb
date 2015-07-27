FactoryGirl.define do
  factory :vacancy do
    title 'Foo'
    description 'Bar baz quox.'
    location 'Remote'
    email 'john@example.com'
    expire_at 1.week.from_now
  end
end
