class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :raw_address
      t.string :formatted_address
      t.decimal :latitude, :precision => 10, :scale => 8
      t.decimal :longitude, :precision => 11, :scale => 8
      t.text :icon_url
      t.string :name
      t.decimal :rating, :precision => 3, :scale => 2
      t.string :google_places_id

      t.timestamps
    end
  end
end
