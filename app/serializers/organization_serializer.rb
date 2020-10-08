class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :structure, :inn, :ogrn
end
