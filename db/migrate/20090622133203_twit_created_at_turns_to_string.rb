class TwitCreatedAtTurnsToString < ActiveRecord::Migration
  def self.up
    change_column :twits, :twit_created_at, :string
  end

  def self.down
    change_column :twits, :twit_created_at, :time
  end
end
