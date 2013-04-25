class AddExpertiseAndPrefContactToResearchers < ActiveRecord::Migration
  def change
    add_column :researchers, :expertise, :string

    add_column :researchers, :pref_contact, :string

  end
end
