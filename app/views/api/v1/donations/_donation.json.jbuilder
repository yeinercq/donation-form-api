json.extract! donation, :id, :first_name, :last_name, :email, :birth_date, :phone_number, :options, :status, :amount, :created_at, :updated_at
json.card donation.card
json.url donation_url(donation, format: :json)
