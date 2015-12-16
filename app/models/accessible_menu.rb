class AccessibleMenu < ActiveRecord::Base
  attr_accessible :name, :description, :link
  
  has_many :authorizations
  has_many :departments, :through => :authorizations

  validates_uniqueness_of :name
  validates_presence_of :name
end
