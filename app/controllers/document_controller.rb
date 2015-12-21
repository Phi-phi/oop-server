class DocumentController < ApplicationController
  def individual_api
    title = "#{params[:type].upcase} #{params[:name]}"
    @api = Api.find(title)
    #@all_apis = Api.all
    @base_url = "http://localhost:3000/"#"http://sfcongestion.herokuapps.com/"
  end
end
