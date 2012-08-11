class Material < ActiveRecord::Base
  belongs_to :material_group
  belongs_to :material_category
  belongs_to :uom
  has_many :purchase_requisition_items
  has_many :purchase_order_items
  has_many :return_note_items

  validates_presence_of :code
  validates_presence_of :kg, :if => :is_counting_group
  validates_numericality_of :kg, :if => :is_counting_group

  validates_uniqueness_of :code

  def code_name
    if uom
      code + " => " + description + " [" + uom.name + "]" rescue "None"
    else
      code + " => " + description rescue "None"
    end
    
  end

  def self.options
    result = all(:order => "code")
    p = new(:code => "None")
    p.id = 0
    result.insert(0, p)
    result.map {|m| [m.code, m.id]}
  end

  def self.copy(target_id)
    target = find(target_id)
    new(:code => target.code, :material_group_id => target.material_group_id, :material_category_id => target.material_category_id, :description => target.description, :uom_id => target.uom_id, :remark => target.remark)
   
  end

  def is_counting_group
    self.material_group && self.material_group.is_counting?
  end



end
