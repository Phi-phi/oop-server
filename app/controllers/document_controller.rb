class DocumentController < ApplicationController
  def individual_api
    title = "#{params[:type].upcase} #{params[:name]}"
    @api = Api.find(title)
    @base_url = "http://sfcongestion.herokuapps.com/"
  end
end
