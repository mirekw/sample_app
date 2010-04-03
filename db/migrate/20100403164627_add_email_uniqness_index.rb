class AddEmailUniqnessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :inique => true
  end

  def self.down
    remove_index :users, :email
  end
end
