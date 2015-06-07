
var currentView;
console.log("routing");
var GitRouter = Backbone.Router.extend({
  routes: {
      "": "Initial",
      'users': 'index',
      'users/:user_id': 'skillShower'
  },

//var rescueData = new RescueData();
  
  Initial: function(){
    console.log("welcome")
    this.navigate('users/'+signedInUserId, true);
  },

	index: function() {
    console.log("hi")
      var users = new UsersCollection();
      window.usersView = new UsersCollectionView({
        el: $(".main"),
        collection: users
      });
    },

    skillShower: function(user_id) {
      console.log("hi "+user_id)
      skills.fetch({
        success: function(){
          currentView = new SkillsView({
            collection: skills,
            id: user_id
          })
        }
      });
    }
});
var routing = new GitRouter();
Backbone.history.start();