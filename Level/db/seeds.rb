# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	Event.create(name: "vmware", user_id: "1", uncut_exp: "7200", language_id: "1", source_id: "1")
	Language.create(name: "Ruby", color: "Red", badge: "badge.jpg")
	Source.create(name: "Rescue Time")
	User.create(email: "msny@gmail.com")

