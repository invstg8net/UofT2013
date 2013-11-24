class AddActivatedFieldToUser < ActiveRecord::Migration
  def change
    add_column :researchers, :status, :integer, :default => 0
  end
end
