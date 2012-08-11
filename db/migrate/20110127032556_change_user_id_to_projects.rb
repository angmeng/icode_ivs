class ChangeUserIdToProjects < ActiveRecord::Migration
  def self.up
    rename_column(:projects, :user_id, :project_supervisor_id)
    rename_index :projects, :user_id, :project_supervisor_id 
  end

  def self.down
  end
end
