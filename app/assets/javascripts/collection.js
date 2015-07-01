function startCollection(){
// Basic Backbone Collection
console.log("collections");
  // var UserCollection = Backbone.Collection.extend({
  //   model: User,
  //   urlRoot: '/user'
  // });
  var EventCollection = Backbone.Collection.extend({
  	model: levl.event,
    url: '/users/'+userParam+'/events.json'
  });

  var SkillCollection = Backbone.Collection.extend({
  	model: levl.skill,
    url: '/users/'+userParam+'/skills.json'
    // initialize: function(models, args){
    //   this.url = function() { return args.user_url() + '/skills.json'; };
    // }
  });
// initialize a collection of Users
// var users = new UserCollection();
levl.userEvents = new EventCollection();
levl.skills = new SkillCollection();
  
  skillShow();
}