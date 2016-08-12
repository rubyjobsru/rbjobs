class AddSalaryToVacancies < ActiveRecord::Migration[5.0]
  def change
    add_column :vacancies, :salary_min, :decimal
    add_column :vacancies, :salary_max, :decimal
    add_column :vacancies, :salary_currency, :string, limit: 3
    add_column :vacancies, :salary_unit, :string
  end
end
