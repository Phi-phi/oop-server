class Api < ActiveRecord::Base
  has_many :api_parameters, foreign_key: :api_name
  self.primary_key = 'name'

  validates :name, presence: true
  validates :description, presence: true
  validates :resource_url, presence: true
end
