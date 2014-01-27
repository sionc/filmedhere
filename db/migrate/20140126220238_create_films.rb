class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.integer :release_year
      t.string :production_company
      t.string :distributor
      t.string :director
      t.string :writers
      t.string :actors

      t.timestamps
    end
  end
end
