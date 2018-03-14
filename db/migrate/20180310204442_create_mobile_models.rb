class CreateMobileModels < ActiveRecord::Migration
  def change
    create_table :mobile_models do |t|
      t.integer :model_id
      t.string :model_n
      t.integer :mobile_make_id

      t.timestamps null: false
    end
  end
end
