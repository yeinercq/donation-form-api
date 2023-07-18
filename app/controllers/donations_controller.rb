class DonationsController < ApplicationController
  before_action :set_donation, only: [:edit, :update, :destroy]

  def index
    @donations = Donation.ordered
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_donation
    @donation = Donation.find(params[:id])
  end

  def donation_params
    params.require(:donation).permit(
      :first_name,
      :last_name,
      :email,
      :birth_date,
      :phone_number,
      :amount,
      options: [:user_agent, :ip_address]
    )
  end
end
