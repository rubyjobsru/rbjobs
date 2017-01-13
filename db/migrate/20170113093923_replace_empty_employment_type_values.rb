class ReplaceEmptyEmploymentTypeValues < ActiveRecord::Migration[5.0]
  def up
    Vacancy.where(employment_type: [nil, '']).find_each do |vacancy|
      vacancy.update!(employment_type: Vacancy::EMPLOYMENT_TYPE_OTHER)
    end
  end

  def down
    Vacancy.where(employment_type: EMPLOYMENT_TYPE_OTHER).find_each do |vacancy|
      vacancy.update!(employment_type: nil)
    end
  end
end
