class StaffSerializer
  include JSONAPI::Serializer
  attributes :id, :email
end
