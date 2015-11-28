class Classroom < ActiveRecord::Base
  serialize :location

  belongs_to :building
  has_many :access_points
  has_many :users, through: :access_points
end
