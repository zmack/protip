class AddVotesAndRatingToTwits < ActiveRecord::Migration
  def self.up
    add_column :twits, :rating, :integer
    add_column :twits, :votes, :integer, :unsigned => true
  end

  def self.down
    remove_column :twits, :rating
    remove_column :twits, :votes
  end
end
