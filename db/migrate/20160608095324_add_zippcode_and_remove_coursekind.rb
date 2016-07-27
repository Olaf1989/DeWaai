class AddZippcodeAndRemoveCoursekind < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :string
    remove_column :courses, :coursekind_id
  end
end
