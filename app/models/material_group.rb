class MaterialGroup < ActiveRecord::Base
  has_many :materials

  validates_presence_of :name
  validates_uniqueness_of :name
end
