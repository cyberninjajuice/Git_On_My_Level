// Basic Backbone Collection for Users

var UserCollection = Backbone.Collection.extend({
  model: User,
  url: '/users'
});

// initialize a collection of Users
var userCollection = new UserCollection();