class StaffOrganizationsSerializer < ActiveModel::Serializer
  attributes :id, :name, :structure, :inn, :ogrn
  has_many :clients
end
