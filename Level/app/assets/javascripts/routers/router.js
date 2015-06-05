var Router = Backbone.Router.extend({
   routes: {
      'users': 'index',
      'users/:id': 'skillShower'
  },

//var rescueData = new RescueData();


	index: function() {
      var users = new UsersCollection();
      window.usersView = new UsersCollectionView({
        el: $(".main"),
        collection: users
      });
    },
    skillShower: function(id) {
    	var skills= new SkillsCollection();
    	window.skillsView = new SkillsView({
    		collection: skill
    	})
    }

});

$(function(){
	window.router = new Router(),
	Backbone.history.start()
})