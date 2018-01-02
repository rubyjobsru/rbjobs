# frozen_string_literal: true
require 'rails_helper'

class VacancyScopesTest < ActiveSupport::TestCase
  fixtures(:vacancies)

  def test_approved
    collection = Vacancy.approved

    assert_includes(collection, vacancies(:approved), 'Includes approved')
    assert_includes(collection, vacancies(:archived), 'Includes archived')
    assert_not_includes(collection, vacancies(:pending), 'Excludes pending')
  end

  def test_pending
    collection = Vacancy.pending

    assert_includes(collection, vacancies(:pending), 'Includes pending')
    assert_not_includes(collection, vacancies(:approved), 'Excludes approved')
    assert_not_includes(collection, vacancies(:archived), 'Excludes archived')
  end

  def test_valid_on
    collection = Vacancy.valid_on(Date.current)

    assert_includes(collection, vacancies(:pending), 'Includes pending')
    assert_includes(collection, vacancies(:approved), 'Includes approved')
    assert_not_includes(collection, vacancies(:archived), 'Excludes archived')
  end

  def test_recent
    collection = Vacancy.recent

    # The collection must sorted in descent order
    assert(collection.first.id > collection.second.id)
    assert(collection.second.id > collection.third.id)
  end

  def test_online
    collection = Vacancy.online

    assert_includes(collection, vacancies(:approved), 'Includes approved')
    assert_not_includes(collection, vacancies(:pending), 'Excludes pending')
    assert_not_includes(collection, vacancies(:archived), 'Excludes archived')
  end
end

class VacancyInstanceMethodsTest < ActiveSupport::TestCase
  fixtures(:vacancies)

  def test_approve_bang
    vacancy = vacancies(:pending)

    vacancy.approve!

    assert_not_nil(vacancy.approved_at, 'Sets apptoval timestamp')
  end

  def test_refuse_bang
    vacancy = vacancies(:approved)

    vacancy.refuse!

    assert_nil(vacancy.approved_at, 'Drops apptoval timestamp')
  end

  def test_approved_predicate
    assert_predicate(vacancies(:approved), :approved?)
    assert_not_predicate(vacancies(:pending), :approved?)
  end

  def test_expired_predicate
    assert_predicate(vacancies(:archived), :expired?)
    assert_not_predicate(vacancies(:approved), :expired?)
  end

  def test_remote_position_predicate
    remote = Vacancy.new(remote_position: true)
    onsite = Vacancy.new(remote_position: false)

    assert_predicate(remote, :remote_position?)
    assert_not_predicate(onsite, :remote_position?)
  end
end

class VacancyValidationsTest < ActiveSupport::TestCase
  def test_title_presence
    untitled = Vacancy.new(title: nil)
    titled = Vacancy.new(title: 'Senior Ruby Developer')

    untitled.validate
    titled.validate

    assert(untitled.errors.include?(:title))
    assert_not(titled.errors.include?(:title))
  end

  def test_description_presence
    undescribed = Vacancy.new(description: nil)
    described = Vacancy.new(description: 'Foo bar. Baz quoz.')

    undescribed.validate
    described.validate

    assert(undescribed.errors.include?(:description))
    assert_not(described.errors.include?(:description))
  end

  def test_location_presence
    unlocated = Vacancy.new(location: nil)
    located = Vacancy.new(location: 'Berlin, Germany')
    remote = Vacancy.new(location: nil, remote_position: true)

    unlocated.validate
    located.validate
    remote.validate

    assert(unlocated.errors.include?(:location))
    assert_not(located.errors.include?(:location))
    assert_not(remote.errors.include?(:location))
  end

  def test_email_presence
    unemailed = Vacancy.new(email: nil)
    emailed = Vacancy.new(email: 'foo@example.com')

    unemailed.validate
    emailed.validate

    assert(unemailed.errors.include?(:email))
    assert_not(emailed.errors.include?(:email))
  end

  def test_email_format
    wrong_formatted = Vacancy.new(email: 'foo@')
    properly_formatted = Vacancy.new(email: 'foo@example.com')

    wrong_formatted.validate
    properly_formatted.validate

    assert(wrong_formatted.errors.include?(:email))
    assert_not(properly_formatted.errors.include?(:email))
  end

  def test_expire_at_presence
    empty = Vacancy.new(expire_at: nil)
    future = Vacancy.new(expire_at: 1.week.from_now)

    empty.validate
    future.validate

    assert(empty.errors.include?(:expire_at))
    assert_not(future.errors.include?(:expire_at))
  end

  def test_salary_min_numericality
    empty = Vacancy.new(salary_min: nil)
    zero = Vacancy.new(salary_min: 0)
    negative = Vacancy.new(salary_min: -1)
    nondigital = Vacancy.new(salary_min: 'foo')

    empty.validate
    zero.validate
    negative.validate
    nondigital.validate

    assert(negative.errors.include?(:salary_min))
    assert(nondigital.errors.include?(:salary_min))
    assert_not(empty.errors.include?(:salary_min))
    assert_not(zero.errors.include?(:salary_min))
  end

  def test_salary_max_numericality
    empty = Vacancy.new(salary_max: nil)
    zero = Vacancy.new(salary_max: 0)
    negative = Vacancy.new(salary_max: -1)
    nondigital = Vacancy.new(salary_max: 'foo')

    empty.validate
    zero.validate
    negative.validate
    nondigital.validate

    assert(negative.errors.include?(:salary_max))
    assert(nondigital.errors.include?(:salary_max))
    assert_not(empty.errors.include?(:salary_max))
    assert_not(zero.errors.include?(:salary_max))
  end

  def test_salary_currency_in_range
    empty = Vacancy.new(salary_currency: nil)
    in_range = Vacancy.new(salary_currency: Vacancy::CURRENCY_EUR)
    out_of_range = Vacancy.new(salary_currency: 'FOO')

    empty.validate
    in_range.validate
    out_of_range.validate

    assert(out_of_range.errors.include?(:salary_currency))
    assert_not(empty.errors.include?(:salary_currency))
    assert_not(in_range.errors.include?(:salary_currency))
  end

  def test_salary_unit_in_range
    empty = Vacancy.new(salary_unit: nil)
    in_range = Vacancy.new(salary_unit: Vacancy::SALARY_UNIT_HOUR)
    out_of_range = Vacancy.new(salary_unit: 'FOO')

    empty.validate
    in_range.validate
    out_of_range.validate

    assert(out_of_range.errors.include?(:salary_unit))
    assert_not(empty.errors.include?(:salary_unit))
    assert_not(in_range.errors.include?(:salary_unit))
  end

  def test_employment_type_in_range
    empty = Vacancy.new(employment_type: nil)
    in_range = Vacancy.new(employment_type: Vacancy::EMPLOYMENT_TYPE_FULLTIME)
    out_of_range = Vacancy.new(employment_type: 'FOO')

    empty.validate
    in_range.validate
    out_of_range.validate

    assert(out_of_range.errors.include?(:employment_type))
    assert_not(empty.errors.include?(:employment_type))
    assert_not(in_range.errors.include?(:employment_type))
  end
end
