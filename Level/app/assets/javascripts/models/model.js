var User = Backbone.Model.extend({
	url: '/users',
 initialize: function() {
  console.log("user hi")
	}
});

var Event = Backbone.Model.extend({
	initialize: function(){
    console.log("event hi");
	}
});

var Skill = Backbone.Model.extend({
	initialize: function(){
	 console.log("skill hi")
  }
});

console.log("Models: Backbone Works")
