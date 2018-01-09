class CreateImageTransformations < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_transformations do |t|
      t.jsonb :specs
      t.jsonb :image_data
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
