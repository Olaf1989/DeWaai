class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :classtype
      t.string :name
      t.boolean :damage

      t.timestamps null: false
    end
  end
end
