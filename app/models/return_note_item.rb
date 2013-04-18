class ReturnNoteItem < ActiveRecord::Base
  belongs_to :return_note
  belongs_to :material
  belongs_to :project
  belongs_to :product
end
