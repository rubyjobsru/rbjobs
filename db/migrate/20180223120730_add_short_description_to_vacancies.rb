class AddShortDescriptionToVacancies < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancies, :short_description, :string, limit: 140
  end
end
