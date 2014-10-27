class CreateCollaborators < ActiveRecord::Migration
  def up
    create_table :collaborators do |t|
      t.integer :researcher_id
      t.integer :collabid
      t.boolean :confirmed, :default => false

      t.timestamps
    end
  end

  def down
      drop_table :collaborators
  end
end
