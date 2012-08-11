class CreateProjectSupervisors < ActiveRecord::Migration
  def self.up
    create_table :project_supervisors do |t|
      t.string :employee_number, :limit => 45
      t.string :name, :limit => 45
      t.string :email, :limit => 100
      t.string :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :project_supervisors
  end
end
