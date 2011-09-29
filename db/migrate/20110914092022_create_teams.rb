class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.string :name
      t.integer :year_of_creation
      t.string :country

      t.timestamps
    end
  end
end
