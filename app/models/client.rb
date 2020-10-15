class Client < ApplicationRecord
  include DeviseAuthenticatable
  has_many :client_organizations, dependent: :destroy
  has_many :organizations, through: :client_organizations

  validates :full_name, :phone, :email, presence: true
end
