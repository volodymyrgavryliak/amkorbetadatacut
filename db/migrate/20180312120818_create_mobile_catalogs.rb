class CreateMobileCatalogs < ActiveRecord::Migration
  def change
    create_table :mobile_catalogs do |t|
      t.integer :mobile_make_id
      t.integer :model_id
      t.string :catalogId
      t.string :vehicleCategory
      t.string :category
      t.text :features, array: true, default: []
      t.string :modelDescription
      t.string :equipmentVersion
      t.string :doorCount
      t.string :emissionClass
      t.string :fuel
      t.text :power
      t.string :transmission
      t.string :climatisation
      t.string :numSeats
      t.string :cubicCapacity
      t.string :interiorType
      t.text :make
      t.text :model
      t.string :consumptionUnit
      t.string :consumptionInner
      t.string :consumptionOuter
      t.string :consumptionCombined
      t.string :carbonDioxydEmission
      t.boolean :compliant
      t.text :productionPeriod
      t.text :log

      t.timestamps null: false
    end
  end
end
