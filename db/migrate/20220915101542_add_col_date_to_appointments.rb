class AddColDateToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :date, :datetime
  end
end
