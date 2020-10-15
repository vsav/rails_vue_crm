class ClientWithOrganizationsSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :phone, :email
  has_many :organizations
end
