class DelColContactNumberFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :contact_number, :integer
  end
end
