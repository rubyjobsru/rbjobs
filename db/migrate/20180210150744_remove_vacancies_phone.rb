class RemoveVacanciesPhone < ActiveRecord::Migration[5.1]
  def change
    remove_column :vacancies, :phone, :string
  end
end
