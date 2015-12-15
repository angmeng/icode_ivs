class AccessibleMenu < ActiveRecord::Base
  attr_accessible :name, :description, :link
  
  has_many :authorizations
  has_many :departments, :through => :authorizations
end
