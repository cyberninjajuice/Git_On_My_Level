console.log("models");
if(typeof userParam !== "undefined"){
  var User = Backbone.Model.extend({
  url: '/users/'+userParam+".json",
 initialize: function() {
  console.log("user hi")
  }
 });
 user = new User();
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
$(document).ready(function(){
  skillShow();
});
}
