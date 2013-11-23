class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :collab_id
      t.boolean :confirmed

      t.timestamps
    end
  end
end
