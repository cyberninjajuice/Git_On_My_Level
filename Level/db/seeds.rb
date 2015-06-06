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
  Language.create(name: "Ruby", color: "red", badge: "ruby.jpg")
  Language.create(name: "General Software Development", color: "grey", badge: "general.jpg")
  Language.create(name: "JavaScript", color: "brown", badge: "javascript.jpg")
  Language.create(name: "Java", color: "mocha", badge: "java.jpg")
  Language.create(name: "Python", color: "green", badge: "python.jpg")
  Language.create(name: "CSS", color: "purple", badge: "css.jpg")
  Language.create(name: "PHP", color: "lime", badge: "php.jpg")
  Language.create(name: "C++", color: "lightblue", badge: "cplus.jpg")
  Language.create(name: "Shell", color: "grease", badge: "shell.jpg")
  Language.create(name: "C#", color: "blue", badge: "csharp.jpg")
  Language.create(name: "Objective-C", color: "navy", badge: "objectivec.jpg")
  Language.create(name: "R", color: "pink", badge: "r.jpg")
  Language.create(name: "VimL", color: "magenta", badge: "viml.jpg")
  Language.create(name: "Go", color: "gold", badge: "go.jpg")
  Language.create(name: "Perl", color: "silver", badge: "perl.jpg")
  Language.create(name: "CoffeeScript", color: "coffee", badge: "coffeescript.jpg")
  Language.create(name: "HTML", color: "white", badge: "html.jpg")