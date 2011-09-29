class CreateCupWinners < ActiveRecord::Migration
  def change
    create_table :cup_winners do |t|
      t.integer :year
      t.references :cup
      t.references :team

      t.timestamps
    end
  end
end
