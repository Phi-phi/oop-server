class ApiParameter < ActiveRecord::Base
  belongs_to :api, class_name: "Api", foreign_key: :api_name
end
