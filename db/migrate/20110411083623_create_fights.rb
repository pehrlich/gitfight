class CreateFights < ActiveRecord::Migration
  def self.up
    create_table :fights do |t|
      t.integer :defender_id
      t.integer :challenger_id
      t.integer :victor_id
      t.string  :rounds
      t.integer :count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :fights
  end
end
