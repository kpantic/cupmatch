class CreateCups < ActiveRecord::Migration
  def change
    create_table :cups do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      t.references :team
      t.string :country
      t.string :name
      t.integer :year_started
      t.string :frequency

      t.timestamps
    end
  end
end
