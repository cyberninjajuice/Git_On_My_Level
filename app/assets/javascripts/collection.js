function startCollection(){
// Basic Backbone Collection
console.log("collections");
  levl.EventCollection = Backbone.Collection.extend({
  	model: levl.event,
    url: '/users/'+userParam+'/events.json'
  });

  levl.SkillCollection = Backbone.Collection.extend({
  	model: levl.skill,
    url: '/users/'+userParam+'/skills.json'
  });

levl.userEvents = new levl.EventCollection();
levl.skills = new levl.SkillCollection();
  
  skillShow();
}