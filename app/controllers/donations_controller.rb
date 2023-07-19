class DonationsController < ApplicationController
  before_action :set_donation, only: [:edit, :update, :destroy]
  before_action :set_client_ip, :set_user_agent, only: [:create]

  def index
    @donations = Donation.ordered
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.options[:ip_address] = @client_ip
    @donation.options[:user_agent] = @user_agent
    if @donation.save
      redirect_to root_path, notice: "Donacion exitosamente creada."
    else
      # debugger
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

  def set_user_agent
    @user_agent = request.user_agent
  end

  def set_client_ip
    @client_ip = request.ip
  end

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
      card_attributes: [
        :id,
        :_destroy,
        :card_number,
        :security_code,
        :expiration_date,
        :card_type,
        :document_type,
        :document_number,
        :donation_id
      ]
    )
  end
end
