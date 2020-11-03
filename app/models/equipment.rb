class Equipment < ApplicationRecord
  belongs_to :organization, optional: true

  validates :name, :kind, :serial, presence: true
  validates_uniqueness_of :serial
end
