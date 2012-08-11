class Vehicle < ActiveRecord::Base
  has_many :transportation_slips

  validates_presence_of :name
  validates_uniqueness_of :name
end
