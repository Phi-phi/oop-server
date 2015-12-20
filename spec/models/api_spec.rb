require 'rails_helper'

RSpec.describe Api, :type => :model do
  %w(name description resource_url).each do |col|
    it "isn't valid without #{col}" do
      api = Api.new(
          name: 'sample name',
          description: 'hoge hoge',
          resource_url: 'account/sample.json'
      )
      api[col] = nil
      expect(api).not_to be_valid

      api.save
      expect(api.errors[:name]).to be_present
    end
  end
end
