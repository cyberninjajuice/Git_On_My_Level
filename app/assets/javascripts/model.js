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

  $(document).ready(function() {
    startCollection();
  });
}
