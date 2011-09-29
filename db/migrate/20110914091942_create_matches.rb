class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :date
      t.integer :away_team_id
      t.integer :home_team_id
      t.integer :away_team_result
      t.integer :home_team_result
      t.references :cup
      t.references :stadium

      t.timestamps
    end
  end
end
