# == Schema Information
#
# Table name: cards
#
#  id              :bigint           not null, primary key
#  card_number     :string           not null
#  security_code   :string           not null
#  card_type       :integer          not null
#  document_type   :integer          not null
#  document_number :string           not null
#  donation_id     :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  expiration_date :date             not null
#
require 'rails_helper'

RSpec.describe Card, type: :model do
  let!(:donation) { create(:donation_with_card, card: build(:card)) }
  subject(:card) { donation.card }

  describe 'validations' do
    # it { should validate_presence_of(:card_number) }
    # it { should validate_presence_of(:security_code) }
    it { should validate_presence_of(:card_type) }
    it { should validate_presence_of(:document_type) }
    it { should validate_presence_of(:document_number) }
    it { should validate_presence_of(:expiration_date) }
    it { should validate_numericality_of(:card_number) }
    it { should validate_numericality_of(:security_code) }
    it { should validate_numericality_of(:document_number) }
  end

  describe 'associations' do
    it { should belong_to(:donation) }
  end
end
