class TransportationSlip < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :project
  belongs_to :supplier

  validates_presence_of :supplier_id, :description_of_goods, :lorry_number
  validates_numericality_of :quantity, :fee
end
