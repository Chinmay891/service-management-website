class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :area
      t.string :description
      t.integer :charge
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
