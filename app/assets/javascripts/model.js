function initBackbone(){
  console.log("starting model");
var User = Backbone.Model.extend({
  url: '/users/'+userParam+".json",
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


  user = new User();
  event = new Event();
  skill = new Skill();
   $(document).ready(function() {
    startCollection();
  });
}
