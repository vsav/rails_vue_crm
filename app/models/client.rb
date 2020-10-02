class Client < ApplicationRecord
  include DeviseAuthenticatable

  validates :full_name, :phone, presence: true
end
