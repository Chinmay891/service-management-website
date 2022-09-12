class AddColStatusToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :status, :boolean, default: false
  end
end
