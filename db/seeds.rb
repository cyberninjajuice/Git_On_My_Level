# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  file = File.read("rescueSecret.json")
  data = JSON.parse(file)
  apiKey = data["secret"]
  user = User.create(email: "msny@gmail.com", rescue_key: apiKey)
	

	Source.create(name: "Rescue Time", exp_multiplier: 0.5, logo: "rescuetime.jpg")
  Source.create(name: "Mylevl Quests", exp_multiplier: 1, logo: "MyLevl.jpg")
  Language.create(name: "Ruby", color: "red", badge: "devicon-ruby-plain colored")
  Language.create(name: "General Software Development", color: "grey", badge: "mdi-hardware-desktop-mac")
  Language.create(name: "JavaScript", color: "yellow", badge: "devicon-javascript-plain colored")
  Language.create(name: "Java", color: "brown darken-1", badge: "devicon-java-plain-wordmark colored")
  Language.create(name: "Python", color: "green", badge: "devicon-python-plain-wordmark colored")
  Language.create(name: "CSS", color: "purple accent-4", badge: "devicon-css3-plain-wordmark colored")
  Language.create(name: "PHP", color: "lime", badge: "devicon-php-plain colored")
  Language.create(name: "C++", color: "light-blue", badge: "devicon-cplusplus-plain-wordmark colored")
  Language.create(name: "Shell", color: "blue-grey", badge: "shell.jpg")
  Language.create(name: "C#", color: "blue", badge: "devicon-csharp-plain-wordmark colored")
  Language.create(name: "Objective-C", color: "indigo", badge: "devicon-c-plain-wordmark colored")
  Language.create(name: "R", color: "pink", badge: "r.jpg")
  Language.create(name: "VimL", color: "teal", badge: "devicon-vim-plain colored")
  Language.create(name: "Go", color: "orange", badge: "devicon-go-line colored")
  Language.create(name: "Perl", color: "deep-orange", badge: "perl.jpg")
  Language.create(name: "CoffeeScript", color: "brown darken-4", badge: "devicon-coffeescript-original-wordmark colored")
  Language.create(name: "HTML", color: "amber", badge: "devicon-html5-plain-wordmark colored")
  user.events.create(name: "vmware", user_id: "1", uncut_exp: "2200", language_id: "1", source_id: "1")
  Admin.create(email: "barbara@gmail.com", password: "password", non_profit: true, tax_id: "284595-2234")
  Quest.create(name: "Build a new Website for my non-profit!", admin_id: 1, language_id: 2, source_id: 2, bounty: 3000, link: "http://codecademy.com", quantity: 30)