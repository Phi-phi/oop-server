# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Classroom.create(name:"TestClassroom", location:["test_location_X", "test_location_Y"])
AccessPoint.create(macaddr:"TestAP", classroom_id:1)
