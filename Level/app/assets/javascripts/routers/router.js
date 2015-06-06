var currentView;
console.log("routing");
var Router = Backbone.Router.extend({
  routes: {
      "": "skillShower",
      'users': 'index',
      'users/:id': 'skillShower'
  },

//var rescueData = new RescueData();
  
  loggedIn: function(){
    console.log("welcome")
  },

	index: function() {
    console.log("hi")
      var users = new UsersCollection();
      window.usersView = new UsersCollectionView({
        el: $(".main"),
        collection: users
      });
    },

    skillShower: function(uid) {
      console.log("hi skillshower")
      skills.fetch({
        success: function(){
          currentView = new SkillsView({
            collection: skills
          }).render(1);
        }
      });
    }
});
var routing= new Router();
Backbone.history.start()