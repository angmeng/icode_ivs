class Term < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.options
    result = all(:order => "name")
    a = Term.new(:name => "None")
    a.id = 0
    result.insert(0, a)
    result.map {|c| [c.name, c.id]}
  end
end
