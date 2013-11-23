class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :researcher_id
      t.integer :collab_id
      t.boolean :confirmed, :default => false

      t.timestamps
    end
  end
end
