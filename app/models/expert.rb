class Expert < ActiveRecord::Base

  belongs_to :user
attr_accessible :active, :topic, :researcher_count

end

