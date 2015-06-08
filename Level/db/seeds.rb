# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  file= File.read("rescueSecret.json")
  data= JSON.parse(file)
  apiKey=data["secret"]
  user = User.create(email: "msny@gmail.com", rescue_key: apiKey)
	
  user.events.create(name: "vmware", user_id: "1", uncut_exp: "7200", language_id: "1", source_id: "1")
	Source.create(name: "Rescue Time", exp_multiplier: 0.5, logo: "rescuetime.jpg")
  Language.create(name: "Ruby", color: "red", badge: "devicon-ruby-plain colored")
  Language.create(name: "General Software Development", color: "grey", badge: "general.jpg")
  Language.create(name: "JavaScript", color: "brown", badge: "devicon-javascript-plain colored")
  Language.create(name: "Java", color: "mocha", badge: "devicon-java-plain-wordmark colored")
  Language.create(name: "Python", color: "green", badge: "devicon-python-plain-wordmark colored")
  Language.create(name: "CSS", color: "purple", badge: "devicon-css3-plain-wordmark colored")
  Language.create(name: "PHP", color: "lime", badge: "devicon-php-plain colored")
  Language.create(name: "C++", color: "lightblue", badge: "devicon-cplusplus-plain-wordmark colored")
  Language.create(name: "Shell", color: "grease", badge: "shell.jpg")
  Language.create(name: "C#", color: "blue", badge: "devicon-csharp-plain-wordmark colored")
  Language.create(name: "Objective-C", color: "navy", badge: "devicon-c-plain-wordmark colored")
  Language.create(name: "R", color: "pink", badge: "r.jpg")
  Language.create(name: "VimL", color: "magenta", badge: "devicon-vim-plain colored")
  Language.create(name: "Go", color: "gold", badge: "devicon-go-line colored")
  Language.create(name: "Perl", color: "silver", badge: "perl.jpg")
  Language.create(name: "CoffeeScript", color: "coffee", badge: "devicon-coffeescript-original-wordmark colored")
  Language.create(name: "HTML", color: "white", badge: "devicon-html5-plain-wordmark colored")