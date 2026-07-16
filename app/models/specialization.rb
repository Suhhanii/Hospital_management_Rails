class Specialization < ApplicationRecord
  has_many :doctor

  validates :name, length: { minimum: 5, maximum: 30 }
end
