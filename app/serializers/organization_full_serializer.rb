class OrganizationFullSerializer < ActiveModel::Serializer
  attributes :id, :name, :structure, :inn, :ogrn
  has_many :equipment
  has_many :clients
end
