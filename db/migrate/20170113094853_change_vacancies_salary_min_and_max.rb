class ChangeVacanciesSalaryMinAndMax < ActiveRecord::Migration[5.0]
  def up
    change_column :vacancies, :salary_min, :integer
    change_column :vacancies, :salary_max, :integer
  end

  def down
    change_column :vacancies, :salary_min, :decimal
    change_column :vacancies, :salary_max, :decimal
  end
end
