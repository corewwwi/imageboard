# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    user1 = User.create(email: "user@gmail.com", password: "12345678")  
    admin = User.create(email: "admin@gmail.com", password: "12345678", admin: true)    
    banned_user = User.create(email: "ban@gmail.com", password: "12345678", banned: true)    

