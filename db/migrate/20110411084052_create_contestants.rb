class CreateContestants < ActiveRecord::Migration
  def self.up
    create_table :contestants do |t|
      t.string :name
      t.string :user
      t.string :cached_data

      t.timestamps
    end
  end

  def self.down
    drop_table :contestants
  end
end
