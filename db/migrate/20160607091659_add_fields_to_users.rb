class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :surenamePrefix, :string
    add_column :users, :surename, :string
    add_column :users, :birthdate, :date
    add_column :users, :city, :string
    add_column :users, :telephone, :integer
  end
end
