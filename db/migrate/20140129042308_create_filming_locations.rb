class CreateFilmingLocations < ActiveRecord::Migration
  def change
    create_table :filming_locations do |t|
      t.integer :film_id
      t.integer :location_id
      t.text :fun_facts

      t.timestamps
    end
  end
end
