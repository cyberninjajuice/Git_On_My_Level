var levl = {};
function initBackbone(){
  console.log("starting model");
levl.User = Backbone.Model.extend({
  url: '/users/'+userParam+".json",
 initialize: function() {
  console.log("user hi")
  }
 });

 levl.Event = Backbone.Model.extend({
  initialize: function(){
    console.log("event hi");
  }
 });

  levl.Skill = Backbone.Model.extend({
  initialize: function(){
   console.log("skill Initialized")
  }
  });


  levl.user = new levl.User();
  levl.event = new levl.Event();
  levl.skill = new levl.Skill();
   $(document).ready(function() {
    startCollection();
  });
}
