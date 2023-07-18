class Api::V1::DonaronlineController < Api::V1::AuthenticatedController

  # curl -X GET "localhost:3000/api/v1/donaronline/health"
  def health
    render json: { message: "API is Ok!" }
  end

  def index
    render json: { current_api_token: current_api_token.id, current_user: current_user.email }
  end
end
