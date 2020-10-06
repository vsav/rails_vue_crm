class ClientOrganizationsSerializer < ActiveModel::Serializer
  attributes :id, :name, :structure, :inn, :ogrn
end
