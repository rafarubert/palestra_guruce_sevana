class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :gender
      t.boolean :inactive

      t.timestamps
    end
  end
end
