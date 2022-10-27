class Employment < ApplicationRecord
  has_many :users
  validates_uniqueness_of :employer
  validates_presence_of :employer, :start_date, :end_date
end
