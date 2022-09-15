class AddColContactNumberToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :contact_number, :string
  end
end
