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
require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_numericality_of(:phone_number) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
    it { should validate_presence_of(:card) }
  end

  describe 'associations' do
    it { should have_one(:card) }
  end
end
