# frozen_string_literal: true

module Vacancies
  class Trackable < SimpleDelegator
    def traits
      @traits ||= {
        id: id,
        salary_min: salary_min,
        salary_max: salary_max,
        salary_currency: salary_currency,
        salary_unit: salary_unit,
        employment_type: employment_type,
        remote_position: remote_position,
        created_at: timestamp_traits_for(created_at.to_datetime),
        approved_at: approved_at ? timestamp_traits_for(approved_at.to_datetime)
                                 : nil
      }
    end

    private

    def timestamp_traits_for(timestamp)
      {
        hour: timestamp.hour,
        minute: timestamp.min,
        day: timestamp.mday,
        week: timestamp.cweek,
        month: timestamp.month,
        quarter: quarter_for(timestamp),
        year: timestamp.year,
        day_of_week: timestamp.wday,
        day_of_year: timestamp.yday,
        iso8601: timestamp.iso8601
      }
    end

    def quarter_for(timestamp)
      case timestamp.month
      when 1..3 then 1
      when 4..6 then 2
      when 7..9 then 3
      when 10..12 then 4
      end
    end
  end
end
