class User < ApplicationRecord
  belongs_to :employment, optional: true
  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name, :phone
end
