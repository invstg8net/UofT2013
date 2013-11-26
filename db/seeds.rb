# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
superuser = Researcher.new 
superuser.name = "superuser"
superuser.password = "password"
superuser.email = "invstg8net@gmail.com"
superuser.superuser = true
superuser.phone_number = "+12898029128"
superuser.status = 1
superuser.Is_Admin = true
superuser.expertise = "invstg8.net"
superuser.save
expert = Expert.new
expert.topic = "News"
expert.save
expert = Expert.new
expert.topic = "Sciences"
expert.save
expert = Expert.new
expert.topic = "Politics"
expert.save
expert = Expert.new
expert.topic = "Weather"
expert.save
