// Basic Backbone Collection
console.log("collections");
  var UserCollection = Backbone.Collection.extend({
    model: User,
    url: '/users'
  });
  var EventCollection = Backbone.Collection.extend({
  	model: Event,
    url: '/users/1/events.json'
  });

  var SkillCollection = Backbone.Collection.extend({
  	model: Skill,
    url: '/users/1/skills.json'
  });
// initialize a collection of Users
var users = new UserCollection();
var events = new EventCollection();
var skills = new SkillCollection();