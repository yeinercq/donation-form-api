require 'rails_helper'

RSpec.describe "Api::V1::Donaronlines", type: :request do
  context "with no token" do
    describe "GET /api/v1/donaronlines/health" do
      it "should have bad credentials message" do
        get api_v1_donaronline_health_path
        expect(response).to have_http_status(401)
        expect(response.body).to eq "{\"message\":\"Bad credentials\"}"
      end
    end
  end

  context "with valid token" do
    let(:user) { create :user }
    let(:api_token) { user.api_tokens.create! }

    describe "GET /api/v1/donaronlines/health" do
      it "should have API is Ok message" do
        get api_v1_donaronline_health_path, headers: { HTTP_AUTHORIZATION: "Token token=#{api_token.token}" }
        expect(response).to have_http_status(200)
        expect(response.body).to eq "{\"message\":\"API is Ok!\"}"
      end
    end
  end
end
