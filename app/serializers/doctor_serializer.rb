class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :specialization_id, :contact_number, :contact_number
end