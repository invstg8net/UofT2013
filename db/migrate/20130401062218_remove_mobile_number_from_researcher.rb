class RemoveMobileNumberFromResearcher < ActiveRecord::Migration
  def change
    remove_column :researchers, :mobile_number, :string
  end

end
