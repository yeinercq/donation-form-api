# == Schema Information
#
# Table name: cards
#
#  id              :bigint           not null, primary key
#  card_number     :string           not null
#  security_code   :string           not null
#  expiration_date :string           not null
#  card_type       :integer          not null
#  document_type   :integer          not null
#  document_number :string           not null
#  donation_id     :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# create(card_number: "123456789123", security_code: "123", expiration_date: "12/24", card_type: :visa, document_type: :cc, document_number: "123456", donation: donation)
class Card < ApplicationRecord
  belongs_to :donation

  validates :card_number, :security_code, :expiration_date, :card_type, :document_type, :document_number, presence: true
  validates :card_number, numericality: { greater_than: 0 } # TODO: Validates max numbers
  validates :security_code, numericality: { greater_than: 0 }
  validates :document_number, numericality: { greater_than: 0 }
  validate :correct_card_number_digits_count
  validate :correct_security_code_digits_count

  enum card_type: { visa: 1, mastercard: 2, maestro: 3 }
  enum document_type: { nit: 1, cc: 2 }

  private

  def correct_card_number_digits_count
    if card_number.length != 12
      errors.add(:card_number, "must have 12 digits")
    end
  end

  def correct_security_code_digits_count
    if card_number.length != 3
      errors.add(:security_code, "must have 3 digits")
    end
  end
end
