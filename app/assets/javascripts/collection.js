function startCollection(){
// Basic Backbone Collection
console.log("collections");
  // var UserCollection = Backbone.Collection.extend({
  //   model: User,
  //   urlRoot: '/user'
  // });
  var EventCollection = Backbone.Collection.extend({
  	model: event,
    url: '/users/'+userParam+'/events.json'
  });

  var SkillCollection = Backbone.Collection.extend({
  	model: skill,
    url: '/users/'+userParam+'/skills.json'
    // initialize: function(models, args){
    //   this.url = function() { return args.user_url() + '/skills.json'; };
    // }
  });
// initialize a collection of Users
// var users = new UserCollection();
var userEvents = new EventCollection();
var skills = new SkillCollection();
  $(document).ready(function() {
    skillShow();
  });
}