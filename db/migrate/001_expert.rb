class Expert < ActiveRecord::Migration
  def self.up
     create_table :experts do |t|
        t.column :topic, :string, :limit => 32, :null => false
        t.column :researcher_count, :integer, :default => 1
        t.column :active, :boolean, :default => true
     end
  end

  def self.down
    drop_table :expert
  end
end

