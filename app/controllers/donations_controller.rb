class DonationsController < ApplicationController
  before_action :set_donation, only: [:edit, :update, :destroy]

  def index
    @donations = Donation.ordered
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    if @donation.save
      redirect_to root_path, notice: "Donacion exitosamente creada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @donation.update(donation_params)
      redirect_to donations_path, notice: "Donacion exitosamente editada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @donation.destroy
      redirect_to donations_path, notice: "Donacion exitosamente eliminada."
    end
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
