class StoreLocation < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :invoice_items
  has_many :stocks, :dependent => :destroy
  has_many :products, :through => :stocks
  has_many :stock_adjustments
  has_many :stock_transfers
  has_many :products
  has_many :goods_receive_note_items

  
  validates_presence_of :name
  validates_uniqueness_of(:name)
  
  after_create :create_default_stock
  
  MAIN_LOCATION = 1

  def self.options
    result = all(:order => "name")
    p = new(:name => "None")
    p.id = 0
    result.insert(0, p)
    result.map {|i| [i.name, i.id]}
  end
  
  def verify_for_destroy
    checked = false
    if id == MAIN_LOCATION
      msg = (I18n.t("flashes.cannot_destroy_builtin"))
    else
      if stock_transfers.size.zero?
        if stock_adjustments.size.zero?
          
          num = 0
          stocks.each {|s|
            num += 1 unless s.quantity == 0  
          }
          
          if num > 1
            msg = (I18n.t("flashes.adjust_quantity_first:"))
          else
            destroy
            checked = true
            msg = (I18n.t("flashes.successfully_destroyed"))
          end
          
        else
          msg = "location cannot be delete due to having purchase invoice item"
        end
      else
        msg = "location cannot be delete due to having invoice item"
      end if goods_receive_note_items.empty?
    end
    
    
    return checked, msg
  end
  
  private
  
  def create_default_stock
    Product.all.each {|p|
      stocks.create(:product_id => p.id)
    }
  end
  
end
