class Product < ActiveRecord::Base
  #versioned
  belongs_to :product_category
  has_many :invoice_items
  has_many :purchase_requisition_items
  has_many :product_movements
  has_many :stocks
  has_many :store_locations, :through => :stocks
  has_many :stock_adjustments
  has_many :customer_pricings
  has_many :customers, :through => :customer_pricings
  has_many :commissions
  has_many :salesmen, :through => :commissions
  has_many :stock_transfers
  belongs_to :product_group
  belongs_to :store_location  
  belongs_to :uom
  has_many :return_note_items

  
  
  has_attached_file :photo,
       :styles => {
       :thumb=> "100x100#",
       :medium => "300x300>"
       }

  attr_protected :id
  delegate :name, :description, :to => :product_category, :prefix => true
  
  validates_presence_of(:code, :name)
  validates_uniqueness_of(:code)
  #validates_numericality_of(:selling_price)
  
  validates_attachment_content_type :photo,
    :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'],
    :message => "only image files are allowed"

  #validates_attachment_size :photo,
  #  :less_than => 1.megabyte, #another option is :greater_than
  #  :message => "max size is 1M"
  
  named_scope :by_category, {:joins => :product_category, :order => 'product_categories.name, name' }
  
  #after_create :generate_customer_pricing

    def verify_for_destroy
      checked = true
      checked = false if invoice_items.first
      checked = false if purchase_requisition_items.first
      checked = false if product_movements.first
      checked = false if stocks.first
      checked = false if stock_adjustments.first
      checked = false if customer_pricings.first
      checked = false if stock_transfers.first
      checked = false if commissions.first
      checked = false if return_note_items.first
      if checked
	destroy      
      else
	self.active = false
        save!      
      end
	      
      
#    checked = false
#    if invoice_items.size.zero?
#      if purchase_invoice_items.size.zero?
#        msg = (I18n.t("flashes.successfully_destroyed"))
#        checked = true
#        destroy
#      else
#        msg = (I18n.t("flashes.cannot_destroy_due_to"))
#      end
#    else
#      msg = (I18n.t("flashes.cannot_destroy_due_to"))
#    end
#    return checked, msg
  end
  
  def self.options
    result = all(:order => "code")
    p = new(:name => "None")
    p.id = 0
    result.insert(0, p)
    result.map {|p| [p.code_name, p.id]}
  end
  
  def create_default_uom
    i = product_uoms.new
    i.name = "Unknown"
    i.rate = 1
    i.selling_price = 0.00
    i.cost = 0.00
    i.save!
    i
  end
  
  def add_uom(opt)
    unless opt[:name].blank?
      p = product_uoms.new
      p.name = opt[:name]
      p.description = opt[:description]
      p.rate = opt[:rate].to_f rescue 1.0
      p.selling_price_a = opt[:selling_price_a].to_f rescue 0.00
      p.selling_price_b = opt[:selling_price_b].to_f rescue 0.00
      p.cost = opt[:cost].to_f rescue 0.00
      p.save!
    end
  end

  def add_location(opt)
    self.store_location_id = opt[:store_location_id].to_i
    save!
  end
  
  def remove_location
    self.store_location_id = 0
    save!
  end

  def self.next_previous_label(current_record_id)
    f = self.first
    l = self.last
    n = self.find_next_record(current_record_id, l.id)
    p = self.find_previous_record(current_record_id, f.id)

    return f, l, n, p
  end
  
  def code_name
    code + " - " + name rescue "-"
  end
  

  
  def average_cost
    total = purchase_invoice_items.inject(0) {|sum, c| sum + c.unit_price }
    cost = total / purchase_invoice_items.length rescue cost = 0.0
    cost
      
  end
  
  def total_open_balance
    total_open = 0
    stocks.each {|ss|
      total_open += ss.opening_balance
    } 
    
    total_open
  end
  
  def on_hand_quantity
    total = 0
    stocks.each {|s|
      total += s.total_quantity
    } 
    total
  end
  
  def total_cost
    average_cost * on_hand_quantity
  end
  
  private
  
  def generate_customer_pricing
    Customer.all.each do |c|
      cp = CustomerPricing.new
      cp.customer_id = c.id
      cp.product_id = id
      cp.save!
    end
    
    Salesman.all.each do |s|
      c = Commission.new
      c.salesman_id = s.id
      c.product_id = id
      c.save!
    end
    
#    default = product_uoms.create(:name => "Pcs", :description => "Pcs", :rate => 1, :selling_price => 0.00, :cost => 0.00)
#    self.outlet_po_uom_id = default.id
#    self.po_uom_id = default.id
#    self.invoice_uom_id = default.id
#    self.packing_uom_id = default.id
    save!
  end
    
  def self.find_next_record(current_record_id, last_id)
    if current_record_id == last_id
       n = false
    else
      found = false
      number = current_record_id + 1
      until found == true
        n = self.find(number) rescue false
        if n
          found = true
        else
          number += 1
        end
      end

    end

    n
  end

  def self.find_previous_record(current_record_id, first_id)
    if current_record_id == first_id
       p = false

    else

      found = false
      number = current_record_id - 1
      until found == true
        p = self.find(number) rescue false
        if p
          found = true
        else
          number -= 1
        end
      end
    end

    p
  end
  
end
