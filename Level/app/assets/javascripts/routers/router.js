var constantView;
var currentView;
console.log("routing");
$(document).ready(function(){
var GitRouter = Backbone.Router.extend({
  routes: {
      '': 'Initial',
      'users/:user_id': 'skillShower',
      //'users':          'index'
      
  },

//var rescueData = new RescueData();
  
  Initial: function(){
    console.log("welcome")
    //console.log('users/'+signedInUserId)
    this.navigate('users/'+signedInUserId, true);
  },

  skillShower: function(user_id) {
    console.log("hi "+user_id)
    // skills.fetch({
    //   success: function(){
      console.log(user)
    constantView = new UserView({
      model: user,
      id: user_id
    }), 
    currentView = new SkillsView({
        collection: skills,
        id: user_id
         })
    }
});
var routing = new GitRouter();

Backbone.history.start();
});
