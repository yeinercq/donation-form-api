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
FactoryBot.define do
  factory :donation do
    sequence(:first_name) { |n| "Name#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    birth_date { "1990-03-04" }
    phone_number { "1234578" }
    amount { 100000 }

    factory :donation_with_card do
      card { [association(:card)] }
    end
  end
end
