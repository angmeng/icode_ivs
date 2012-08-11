class ReturnNote < ActiveRecord::Base
  has_many :return_note_items
  belongs_to :supplier

  after_create :generate_order_number

  def import_items(item)
    unless item[:quantity].index(/[abcdefghijklmnopqrstuvwxyz]/) or item[:material_id].blank? or item[:quantity].blank?
      return_note_items.create!(:project_id => item[:project_id], :product_id => item[:product_id], :material_id => item[:material_id], :quantity => item[:quantity], :remark => item[:remark])
    else
      return false
    end
  end


  private
  
  def generate_order_number
    setting = Setting.first
    num = setting.return_note_last_number += 1
    self.grn_number = setting.return_note_code + num.to_s

    setting.save!
    save!
  end
end
