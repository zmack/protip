class CreateTwits < ActiveRecord::Migration
  def self.up
    create_table :twits do |t|
      t.string :text
      t.string :username
      t.string :avatar_url
      t.integer :id, :unsigned => true
      t.integer :userid, :unsigned => true
      t.time :twit_created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :twits
  end
end
