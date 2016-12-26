# frozen_string_literal: true

module DateTimeHelpers
  def quarter_for(timestamp)
    case timestamp.month
    when 1..3 then 1
    when 4..6 then 2
    when 7..9 then 3
    when 10..12 then 4
    end
  end
end
