class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.jsonb :image_data

      t.timestamps
    end
  end
end
