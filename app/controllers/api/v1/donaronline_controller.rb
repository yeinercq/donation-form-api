class Api::V1::DonaronlineController < Api::V1::AuthenticatedController

  # curl -X GET "localhost:3000/api/v1/donaronline/health" -H "Authorization: Bearer TOKEN"
  def health
    render json: { message: "API is Ok!" }, status: :ok
  end

  # curl -X GET "localhost:3000/api/v1/donaronline/who_i_am" -H "Authorization: Bearer TOKEN"
  def who_i_am
    render json: { current_api_token: current_api_token.id, current_user: current_user.email }
  end
end
