class PurchaseRequisitionCategory < ActiveRecord::Base
  has_many :purchase_requisitions

  validates_presence_of :name
  validates_uniqueness_of :name
end
