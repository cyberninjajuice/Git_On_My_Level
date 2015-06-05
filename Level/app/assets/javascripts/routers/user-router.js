var Router = Backbone.Router.extend({
   routes: {
      'users': 'index',
  }
});

var rescueData = new RescueData();


 index: function() {
      var users = new UsersCollection();
      window.usersView = new UsersCollectionView({
        el: $(".main"),
        collection: users
      });
    },

$(function(){
	window.router = new UsersRouter(),
	Backbone.history.start()
})