class Organization < ApplicationRecord
  has_many :client_organizations, dependent: :destroy
  has_many :clients, through: :client_organizations
  has_many :equipment

  validates :name, :structure, :inn, :ogrn, presence: true
  validates_uniqueness_of :name, :inn
  validates :inn, numericality: { only_integer: true }, length: { in: 9..12 }
  validates :ogrn, numericality: { only_integer: true }, length: { is: 13 }

  after_save :broadcast_create
  after_update :broadcast_update
  after_destroy :broadcast_destroy

  private

  def broadcast_create
    ActionCable.server.broadcast('organizations', { created: self })
  end

  def broadcast_update
    ActionCable.server.broadcast('organizations', { updated: self })
  end

  def broadcast_destroy
    ActionCable.server.broadcast('organizations', { destroyed: self })
  end
end
