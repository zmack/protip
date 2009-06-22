class AddTwitIdToTwits < ActiveRecord::Migration
  def self.up
    add_column :twits, :twitid, :integer, :unsigned => true
  end

  def self.down
    remove_column :twits, :twitid
  end
end
