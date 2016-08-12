class AddSalaryToVacancies < ActiveRecord::Migration[5.0]
  def change
    add_column :vacancies, :salary_min, :decimal, default: 0.0
    add_column :vacancies, :salary_max, :decimal, default: 0.0
    add_column :vacancies, :salary_currency, :string,
                                             limit: 3,
                                             default: Vacancy::CURRENCY_RUB

    add_column :vacancies, :salary_unit, :string,
                                         default: Vacancy::SALARY_UNIT_MONTH
  end
end
