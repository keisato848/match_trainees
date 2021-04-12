class CreateTrainings < ActiveRecord::Migration[6.0]
  def change
    create_table :trainings do |t|
      t.bigint :owner_id
      t.string :name, null: false
      t.string :place, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.text :content, null: false
      t.bigint :prefecture_id, null: false
      t.timestamps
    end
    
    add_index :trainings, :owner_id
  end
end
