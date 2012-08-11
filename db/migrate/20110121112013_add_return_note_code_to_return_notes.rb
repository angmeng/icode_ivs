class AddReturnNoteCodeToReturnNotes < ActiveRecord::Migration
  def self.up
    add_column :settings, :return_note_code, :string, :default => "GRN"
    add_column :settings, :return_note_last_number, :integer, :default => 1000
  end

  def self.down
    remove_column :return_notes, :return_note_code
    remove_column :return_notes, :return_note_last_number
  end
end
