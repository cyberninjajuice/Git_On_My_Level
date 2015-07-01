var levl = {};
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
   console.log("skill Initialized")
  }
  });


  levl.user = new User();
  levl.event = new Event();
  levl.skill = new Skill();
   $(document).ready(function() {
    startCollection();
  });
}
