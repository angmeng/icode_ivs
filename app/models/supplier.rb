class Supplier < ActiveRecord::Base
  has_many :purchase_requisition_items
  has_many :supplier_payments
  has_many :purchase_orders
  has_many :transportation_slips
  has_many :return_notes
  #attr_accessible :term, :area, :code, :name, :address, :office_phone, :fax_number, :contact_person, :contact_number, :active, :remark, :additional_phone_one, :additional_phone_two, :used_credit

  validates_presence_of(:name, :code)
  validates_uniqueness_of(:name, :code)

  named_scope :currently_active, :conditions => "active = true"
  #after_create :generate_code
  
  attr_accessor :prepared_requisition_items

  def self.store_options
    currently_active.all(:order => "code").map {|p| [p.code_name_for_store, p.id]}
  end

  def self.options
    currently_active.all(:order => "code").map {|p| [p.code_name, p.id]}
  end


  def code_name_for_store
    name + " => " + code rescue name
  end

  def code_name
    code + " => " + name
  end

  def verify_for_destroy
    checked = false
     if supplier_payments.size.zero?
      if purchase_invoices.size.zero?
        msg = (I18n.t("flashes.successfully_destroyed"))
        checked = true
        destroy
      else
        msg = (I18n.t("flashes.cannot_destroy_due_to"))
      end
     else
       msg = (I18n.t("flashes.cannot_destroy_due_to"))
     end
    
    return checked, msg
  end
 
  def current_credit
    used_credit - paid_credit
  end

 private
 
 
  def generate_code
    setting = Setting.first
    self.code = setting.ap_code + (setting.ap_last_number + 1).to_s
    save
    setting.ap_last_number += 1
    setting.save
  end
  
end
