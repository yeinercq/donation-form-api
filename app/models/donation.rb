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
  has_one :card, dependent: :destroy

  validates :first_name, :last_name, :email, :birth_date, :phone_number, :amount, presence: true
  validates :phone_number, numericality: true
  validates :amount, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }

  def donante
    "#{first_name} #{last_name}"
  end
end
