class User < ActiveRecord::Base
  belongs_to :access_point
  has_one :classroom, through: :access_point
end
