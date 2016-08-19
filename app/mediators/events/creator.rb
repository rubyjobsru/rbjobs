# frozen_string_literal: true
module Events
  class Creator
    def initialize(event_code, vacancy)
      @event_code = event_code
      @vacancy = vacancy
    end

    def self.run(*args)
      new(*args).call
    end

    def call
      KeenJob.perform_later(event_code, traits)
    end

    private

    attr_reader :vacancy,
                :event_code

    def traits
      @traits ||= {
        hour: hour_for(event_timestamp),
        minute: minute_for(event_timestamp),
        day: day_for(event_timestamp),
        week: week_for(event_timestamp),
        month: month_for(event_timestamp),
        quarter: quarter_for(event_timestamp),
        year: year_for(event_timestamp),
        day_of_week: day_of_week_for(event_timestamp),
        day_of_year: day_of_year_for(event_timestamp),
        timestamp: event_timestamp.iso8601,
        vacancy: vacancy_traits
      }
    end

    def vacancy_traits
      @vacancy_traits ||= {
        id: vacancy.id,
        salary_min: vacancy.salary_min,
        salary_max: vacancy.salary_max,
        salary_currency: vacancy.salary_currency,
        salary_unit: vacancy.salary_unit,
        employment_type: vacancy.employment_type,
        remote_position: vacancy.remote_position,
        created_at_hour: hour_for(vacancy_creation_timestamp),
        created_at_minute: minute_for(vacancy_creation_timestamp),
        created_at_day: day_for(vacancy_creation_timestamp),
        created_at_week: week_for(vacancy_creation_timestamp),
        created_at_month: month_for(vacancy_creation_timestamp),
        created_at_quarter: quarter_for(vacancy_creation_timestamp),
        created_at_year: year_for(vacancy_creation_timestamp),
        created_at_day_of_week: day_of_week_for(vacancy_creation_timestamp),
        created_at_day_of_year: day_of_year_for(vacancy_creation_timestamp),
        created_at_timestamp: vacancy_creation_timestamp.iso8601,
        approved_at_hour: hour_for(vacancy_approval_timestamp),
        approved_at_minute: minute_for(vacancy_approval_timestamp),
        approved_at_day: day_for(vacancy_approval_timestamp),
        approved_at_week: week_for(vacancy_approval_timestamp),
        approved_at_month: month_for(vacancy_approval_timestamp),
        approved_at_quarter: quarter_for(vacancy_approval_timestamp),
        approved_at_year: year_for(vacancy_approval_timestamp),
        approved_at_day_of_week: day_of_week_for(vacancy_approval_timestamp),
        approved_at_day_of_year: day_of_year_for(vacancy_approval_timestamp),
        approved_at_timestamp: vacancy_approval_timestamp.iso8601
      }
    end

    def event_timestamp
      @event_timestamp ||= DateTime.current
    end

    def vacancy_creation_timestamp
      @vacancy_creation_timestamp ||= vacancy.created_at.to_datetime
    end

    def vacancy_approval_timestamp
      @vacancy_approval_timestamp ||= vacancy.approved_at.to_datetime
    end

    def hour_for(timestamp)
      timestamp.hour
    end

    def minute_for(timestamp)
      timestamp.min
    end

    def day_for(timestamp)
      timestamp.mday
    end

    def week_for(timestamp)
      timestamp.cweek
    end

    def month_for(timestamp)
      timestamp.month
    end

    def quarter_for(timestamp)
      case timestamp.month
      when 1..3 then 1
      when 4..6 then 2
      when 7..9 then 3
      when 10..12 then 4
      end
    end

    def year_for(timestamp)
      timestamp.year
    end

    def day_of_week_for(timestamp)
      timestamp.wday
    end

    def day_of_year_for(timestamp)
      timestamp.yday
    end
  end
end
