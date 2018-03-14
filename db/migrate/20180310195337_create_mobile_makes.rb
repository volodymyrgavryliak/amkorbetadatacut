class CreateMobileMakes < ActiveRecord::Migration
  def change
    create_table :mobile_makes do |t|
      t.integer :make_i
      t.string :make_n
      t.integer :start_from

      t.timestamps null: false
    end
  end
end
