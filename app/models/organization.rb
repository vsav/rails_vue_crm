class Organization < ApplicationRecord
  has_many :client_organizations, dependent: :destroy
  has_many :clients, through: :client_organizations

  validates :name, :structure, :inn, :ogrn, presence: true
end
