class AddFieldsToResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :email, :string
    add_column :researchers, :password_hash, :string
    add_column :researchers, :password_salt, :string
    add_column :researchers, :mobile_number, :string
    add_column :researchers, :phone_number, :string
    add_column :researchers, :name, :string
    add_column :researchers, :remember_created_at, :datetime
    add_column :researchers, :sign_in_count, :integer, :default => 0
    add_column :researchers, :current_sign_in_at, :datetime
    add_column :researchers, :last_sign_in_at, :datetime
    add_column :researchers, :current_sign_in_ip, :string
    add_column :researchers, :last_sign_in_ip, :string
    add_column :researchers, :superuser, :boolean, :default => false
    add_column :researchers, :Is_Admin, :boolean, :default => false
  end
end
