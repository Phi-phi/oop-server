class Classroom < ActiveRecord::Base
  serialize :location

  has_many :access_points
  has_many :users, through: :access_points
end
