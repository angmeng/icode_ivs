class Project < ActiveRecord::Base
  belongs_to :project_supervisor
  has_many :purchase_requisitions
  has_many :purchase_orders
  has_many :purchase_order_items
  has_many :transportation_slips
  has_many :return_note_items


  validates_presence_of :name, :code
  validates_uniqueness_of :name, :code

  named_scope :active, :conditions => "completed = false"

  def code_name
    code + " - " + name rescue "-"
  end

  def self.options
    result = active.all(:order => "code")
    p = new(:name => "None")
    p.id = 0
    result.insert(0, p)
    result.map {|p| [p.code_name, p.id]}
  end

  def	verify_destroy
    checked = true
    checked = false if purchase_requisitions.first
    checked = false if purchase_orders.first
    checked = false if purchase_order_items.first
    checked = flase if transportation_slips.first
    checked = false if return_note_items.first
    if checked
      destroy
    else
      checked
    end
  end

end
