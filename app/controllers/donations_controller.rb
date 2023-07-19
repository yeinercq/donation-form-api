class DonationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new ] # Skip authentications to create a donation
  before_action :set_donation, only: [:edit, :update, :destroy]
  before_action :set_client_ip, :set_user_agent, only: [:create]

  def index
    # If there is not filter date params show donations
    @donations = Donation.where(nil).ordered
    # Else show donations between start_date and end_date
    if params[:start_date].present? and params[:end_date].present?
      @donations =  Donation.filter_by_date(
        Date.parse(params[:start_date]).beginning_of_day,
        Date.parse(params[:end_date]).end_of_day
      ).ordered
    end
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.options[:ip_address] = @client_ip
    @donation.options[:user_agent] = @user_agent
    if @donation.save
      redirect_to thanks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @donation.update(donation_params)
      respond_to do |format|
        format.html { redirect_to donations_path, notice: "Donacion exitosamente editada." }
        format.turbo_stream { flash.now[:notice] = "Donacion exitosamente editada." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @donation.destroy
      respond_to do |format|
        format.html { redirect_to donations_path, notice: "Donacion exitosamente eliminada." }
        format.turbo_stream { flash.now[:notice] = "Donacion exitosamente eliminada." }
      end
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
