var User = Backbone.Model.extend({
	url: '/users',
 initialize: function() {
      //Events
      this.events = new EventCollection();
      this.events.url = '/users/' + this.id + '/events';
      //Skills
      this.skills= new SkillCollection();
      this.skills.url = "/users/"+this.id + "/skills";
	}
})

var Event = Backbone.Model.extend({
	initialize: function(){
	}
})

var Skill = Backbone.Model.extend({
	initialize: function(){
	}
})

console.log("Backbone Works")