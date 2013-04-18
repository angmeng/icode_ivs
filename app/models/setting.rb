class Setting < ActiveRecord::Base
  attr_accessible :ar_code, :ar_last_number, :ap_code, :ap_last_number, :invoice_code, :invoice_last_number, :company_name

  
  CUSTOMER_PAYMENT = 1
  SUPPLIER_PAYMENT = 2
  
  ENGLISH = 1
  CHINESE = 2
  
  LANGUAGE_OPTIONS = [
  ["English", ENGLISH],
  ["华文", CHINESE]
  ].freeze

 
  def forward_to(number_of_days)
    setting = Setting.first
    setting.blowfish += number_of_days.to_i.days
    setting.save
    setting.reload
    setting.blowfish
  end
  
  def backward_to(number_of_days)
    setting = Setting.first
    setting.blowfish -= number_of_days.to_i.days
    setting.save
    setting.reload
    setting.blowfish
  end
  
end
