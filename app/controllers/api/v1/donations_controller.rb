class Api::V1::DonationsController < Api::V1::AuthenticatedController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  before_action :set_client_ip, :set_user_agent, only: [:create]

  def index
    # If there is not filter date params show donations
    # curl -X GET "localhost:3000/api/v1/donations" -H "Authorization: Bearer TOKEN"
    @donations = Donation.where(nil).includes(:card).ordered
    # Else show donations between start_date and end_date
    # curl -X GET "localhost:3000/api/v1/donations?start_date=AAAA-MM-DD&end_date=AAAA-MM-DD" -H "Authorization: Bearer TOKEN"
    if params[:start_date].present? and params[:end_date].present?
      @donations =  Donation.filter_by_date(
        Date.parse(params[:start_date]).beginning_of_day,
        Date.parse(params[:end_date]).end_of_day
      ).includes(:card).ordered
    end
  end

  # curl -X GET "localhost:3000/api/v1/donations/:id" -H "Authorization: Bearer TOKEN"
  def show
  end

  # curl -X POST "localhost:3000/api/v1/donations" -H 'Content-Type: application/json' -H "Authorization: Bearer TOKEN" -d '{ "donation":{"first_name":"Test", "last_name":"Test", "email":"mail@test.com", "birth_date":"2023-07-03", "phone_number":"123456", "amount":"100000", "card_attributes":{"card_number":"123456789012", "security_code":"123", "expiration_date":"2023-07-28", "card_type":"visa", "document_type":"cc", "document_number":"7654321", "_destroy":"false"}} }'
  def create
    @donation = Donation.new(donation_params)
    # Set ip_address and user_agent options to donation
    @donation.options[:ip_address] = @client_ip
    @donation.options[:user_agent] = @user_agent
    if @donation.save
      render @donation, status: :created
      # Send message to donor email
      DonorMailer.with(donation: @donation).donation_email.deliver_later
    else
      render @donation.errors, status: :unprocessable_entity
    end
  end

  # curl -X PATCH "localhost:3000/api/v1/donations/:id" -H 'Content-Type: application/json' -H "Authorization: Bearer TOKEN" -d '{ "donation":{"first_name":"Andrea Maria","last_name":"Roa","email":"andrea@roa.com","birth_date":"2023-07-03","phone_number":"12345678","options":{"ip_address":"127.0.0.1","user_agent":"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0"},"status":null,"amount":"50000.0","card_attributes":{"id":16,"card_number":"","security_code":"123","card_type":"mastercard","document_type":"cc","document_number":"9876543","donation_id":23,"expiration_date":"2023-07-21"}} }'
  def update
    if @donation.update(donation_params)
      render json: { message: "Donacion exitosamente editada." }, status: :ok
    else
      render json: @donation.errors, status: :unprocessable_entity
    end
  end

  # curl -X DELETE http://localhost:3000/api/v1/donations/:id -H "Authorization: Bearer TOKEN"
  def destroy
    if @donation.destroy
      render json: { message: "Donacion exitosamente eliminada." }, status: :ok
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
