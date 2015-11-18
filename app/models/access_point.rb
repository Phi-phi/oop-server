class AccessPoint < ActiveRecord::Base
  belongs_to :classroom
  has_many :users
end
