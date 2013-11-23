class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :researcher_id
      t.integer :sender
      t.string :message

      t.timestamps
    end
  end
end
