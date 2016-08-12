class AddRemotePositionToVacancies < ActiveRecord::Migration[5.0]
  def change
    add_column :vacancies, :remote_position, :boolean, default: false
  end
end
