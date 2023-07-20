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
FactoryBot.define do
  factory :card do
    card_number { 123456789012 }
    security_code { 123 }
    card_type { :visa }
    document_type { :cc }
    document_number { 123456 }
    expiration_date { "2050-01-01" }
    donation
  end
end
