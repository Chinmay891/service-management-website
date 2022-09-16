class RemoveColDateFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :date, :timestamp
  end
end
