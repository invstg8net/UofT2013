class CreateQuestionsTable < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :email
      t.string :topic
      t.string :phone_number
      t.text :body
      t.timestamps
      t.boolean :escalated, :default => :false
      t.datetime :needed_by
      t.string :appended_info, :default => nil
      t.integer :researcher_id
      t.datetime :updated_at
    end
  end
end
