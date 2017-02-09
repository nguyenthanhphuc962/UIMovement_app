class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
