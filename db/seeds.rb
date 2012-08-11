# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
 user = User.first
    if user and user.id == 1
      user.password = "123456"
      user.password_confirmation = "123456"
      user.save
    else
      user = User.new
      user.username = "Admin"
      user.department_id = 1
      user.password = "123456"
      user.password_confirmation = "123456"
      user.save
    end