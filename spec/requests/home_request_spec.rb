require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "GET /index" do
    it "ルートにアクセスすると、正常なhttpステータス(200)を返す" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

end
