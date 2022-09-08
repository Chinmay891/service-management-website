class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :service
      t.references :user
      t.timestamp :date
      t.timestamps
    end
  end
end
