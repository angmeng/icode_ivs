class MaterialCategory < ActiveRecord::Base
  has_many :materials

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.options
    result = all(:order => "name")
    p = new(:name => "None")
    p.id = 0
    result.insert(0, p)
    result.map {|p| [p.name, p.id]}
  end
end
