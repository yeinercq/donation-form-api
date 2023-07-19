class ApiTokensController < ApplicationController
  def index
    @api_tokens = current_user.api_tokens.ordered
  end

  def create
    @api_token = current_user.api_tokens.create!
    respond_to do |format|
      format.html { redirect_to api_tokens_path, notice: "Token exitosamente generado." }
      format.turbo_stream { flash.now[:notice] = "Token exitosamente generado." }
    end
  end

  def destroy
    @api_token = current_user.api_tokens.find(params[:id])
    if @api_token.destroy
      respond_to do |format|
        format.html { redirect_to api_tokens_path, notice: "Token exitosamente eliminado." }
        format.turbo_stream { flash.now[:notice] = "Token exitosamente eliminado." }
      end
    end
  end
end
