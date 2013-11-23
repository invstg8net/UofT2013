class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender
      t.id :receiver
      t.string :message

      t.timestamps
    end
  end
end
