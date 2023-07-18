class Api::V1::DonaronlineController < ActionController::Base
  def health
    render json: { message: "API is Ok!" }
  end
end
