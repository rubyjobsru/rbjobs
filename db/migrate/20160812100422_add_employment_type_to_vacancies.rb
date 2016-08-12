class AddEmploymentTypeToVacancies < ActiveRecord::Migration[5.0]
  def change
    add_column :vacancies, :employment_type,
                           :string,
                           default: Vacancy::EMPLOYMENT_TYPE_FULLTIME
  end
end
