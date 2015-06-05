// Basic Backbone Collection for Users

// Ajax prefileter
$.ajaxPrefilter( function( options, originalOptions, jqxhr ) {
	options.url = "http://localhost:3000" + options.url;
});

var UserCollection = Backbone.Collection.extend({
  model: User,
  url: '/users'
});

var EventCollection = Backbone.Collection.extend({
	model: Event
});

var SkillCollection = Backbone.Collection.extend({
	model: Skill
});
// initialize a collection of Users
var userCollection = new UserCollection();
var eventCollection = new EventCollection();
var skillCollection = new SkillCollection();