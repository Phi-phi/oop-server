require 'rails_helper'

RSpec.describe DocumentController, :type => :controller do

  # サンプルAPIリファレンス
  describe "GET /dev/api/reference/post/account/register" do

    # HTTP 200を返すことをテスト
    it "responds successfully with an HTTP 200 status code" do
      get :api_reference
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    # api_reference テンプレートをレンダリングすることをテスト
    it "renders the index template" do
      get :api_reference
      expect(response).to render_template("api_reference")
    end

    # ページタイトルになるものが正しいかテスト
    specify "the title should be 'POST account/register'" do
      get :api_reference
      api = Api.find_by(name:"POST account/register")
      expect(api).to be_present
    end

  end
end
