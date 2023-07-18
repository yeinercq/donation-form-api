# == Schema Information
#
# Table name: api_tokens
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  token      :text             not null
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ApiToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  encrypts :token, deterministic: true

  private

  def generate_token
    self.token = Digest::MD5.hexdigest(SecureRandom.hex)
  end
end
