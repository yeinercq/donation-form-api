# == Schema Information
#
# Table name: donations
#
#  id           :bigint           not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  email        :string           not null
#  birth_date   :date             not null
#  phone_number :string           not null
#  options      :hstore
#  status       :string
#  amount       :decimal(10, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# Donation.create!(first_name: "Yeiner", last_name: "Carajal Quina", email: "yeiner@carvajal.com", birth_date: "04/04/1993", phone_numb
# er: "1234567", amount: 100000)

class Donation < ApplicationRecord
  include AASM

  has_one :card, dependent: :destroy, inverse_of: :donation

  validates :first_name, :last_name, :email, :birth_date, :phone_number, :amount, presence: true
  validates :phone_number, numericality: true
  validates :amount, numericality: { greater_than: 0 }
  validates :card, presence: true
  # validates :has_valid_card, on: :create

  accepts_nested_attributes_for :card, reject_if: :all_blank, allow_destroy: true

  # Query filters
  scope :ordered, -> { order(id: :desc) }
  scope :filter_by_date, ->(start_date, end_date) { where("donations.created_at >= ? AND donations.created_at <= ?", start_date, end_date) }

  # On CRUD actions updates donation index
  broadcasts_to ->(donation) { "donations" }, inserts_by: :prepend

  def donor
    "#{first_name} #{last_name}"
  end

  # State machine to manage donation status
  aasm column: :status do
    state :recibida, initial: true
    state :aprobada, :rechazada, :cobrada

    event :aprobar do
      transitions from: [:recibida, :rechazada], to: :aprobada
    end

    event :rechazar do
      transitions from: :recibida, to: :rechazada
    end

    event :cobrar do
      transitions from: :aprobada, to: :cobrada
    end
  end


  private

  def has_valid_card
    if cards.count != 12
      errors.add(:card_number, "must have 12 digits")
    end
  end
end
