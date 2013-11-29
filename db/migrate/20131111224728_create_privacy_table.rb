class CreatePrivacyTable < ActiveRecord::Migration
  def up
      create_table :privacies do |t|
          t.integer :researcher_id
          t.integer :namepriv, :default => 0
          t.integer :emailpriv, :default => 0
          t.integer :phonepriv, :default => 0
          t.integer :expertisepriv, :default => 0
          t.integer :regionpriv, :default => 0
          t.integer :pseudonympriv, :default => 0
          end
  end

  def down
      drop_table :privacies
  end
end