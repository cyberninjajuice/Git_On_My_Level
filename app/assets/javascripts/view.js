console.log("view");
  //Single View for a User Only one that Backbone should deal with.
var closer = $('<span class="card-title grey-text text-darken-4"><i class="mdi-navigation-close right"></i></span>');

levl.UserView = Backbone.View.extend({
  tagName: 'div',

  initialize: function(){
    console.log(this.model);
    this.listenTo(this.model, "sync, add, remove, destroy, update", this.fetchingSkills);
    this.fetchingUser()
  },

  events: {
    "click .editing_user": "editForm",
    "click button#update-user": "updateIt"
  },
  
  editForm: function() {
    $("div.edit_form").show();
    $("button.editing_user").hide();
  },

  updateIt: function(event){
    event.preventDefault();
    var email = $("#email")
    var rescueKey = $("#rescue-key")
    var thisView = levl.constantView;

    if(rescueKey.val().length === 40){
      levl.user.save(
      {email: email.val(), rescue_key: rescueKey.val()},
      { success: function(model, response) { 
        thisView.fetchingUser();
        $("div.edit_form").hide();
        $("button.editing_user").show();
      },
       error: function(errors){ console.log(errors);}
      },
      { patch: true }
      );
    } else {
      levl.user.save(
      {email: email.val()},
      { success: function(model, response) { 
        thisView.fetchingUser();
        $("div.edit_form").hide();
        $("button.editing_user").show();
      }, error: function(errors){
        console.log(errors);
      }
      },
      { patch: true }
      );
    }
  },

  fetchingUser: function() {
    //console.log("Fetching user");
    var thisView = this;
    //console.log(thisView)

    var specifyTemp = $('#userTemp').html();
    this.template = _.template(specifyTemp)
    levl.user.fetch({
      success: function(model, response){
        //console.log(model)
        if ( model ) {
          thisView.model = model.toJSON();
          console.log(thisView.model);
          if ( thisView.model.has_rescue ) {
            $("#must-rescue").show();
            initiateViews();
            thisView.render(thisView.id);
          } else {
            $("#must-rescue").hide();
            thisView.renderSetup();
          }
        }
      }, 
      error: function(){
        console.log("people error")
      }
    });
    return this;
  },
  renderSetup: function(){
    var temp =  _.template($('#must-rescue-temp').html());
    var el = this.$el;
    el.empty();
    el.html( temp({user: this.model}) );
    $('#user-area').html(el);
    this.delegateEvents();
    return this;
  },

  render: function(uid){
    console.log("showing" + this.model);
    var temp = this.template;
    console.log(temp)
    
    var el = this.$el;
    el.empty();
    
    el.html(temp({user: this.model}) );
    $('#user-area').html(el);
    this.delegateEvents();
    return this;

  }
});

levl.EventView = Backbone.View.extend({
	tagName: 'li',
	initialize: function(){
    this.$el.addClass("collection-item");
    this.template = _.template($('#event-template').html())
  },
	render: function(){
		this.$el.html(this.template({event: this.model.toJSON()}));
		return this;	
	}
});

levl.EventsView = Backbone.View.extend({
	tagName: 'ul',
	initialize: function() {
    this.$el.addClass("collection overflowing");
    this.listenTo(this.model, "sync, add, remove, destroy", this.fetchingEvents);
    this.fetchingEvents();
	},

  fetchingEvents: function(){
    //console.log(this)
    var thisView = this;
    levl.userEvents.fetch({
      success: function(model, response){
        this.template = _.template($('#event-template').html());
        if( model && model.length>0) {
          thisView.render(thisView.id)
        } else {
          thisView.handleNone();
        }
      },
      error: function(errors){
        console.log(errors)
      } 

    });
  },

  handleNone: function() {
    $('#events-area').append($('<div class="field_with_errors">No events have been logged by this user. Check out <a href="/"> Home </a> Where we explain how to configure <a class="white-text" href="http://rescuetime.com"> Rescue Time for your profession.</a></div>'));
  },
	render: function() {
    var el = this.$el;
    console.log("rendering events")
    el.empty();
    el.append(closer);
    // render a EventView for each event
    this.collection.each(function(event) {
      el.append(new levl.EventView({model: event}).render().el);
    });
    // add the view to the content-area
    $('.events_card').show();
    $('#events-area').html(el);
    return this;
  }

});

levl.SkillView = Backbone.View.extend({
  tagName: 'li',
  initialize: function(){
    this.template = _.template($('#skill-template').html())
  },
  render: function(){
    this.$el.html(this.template({skill: this.model.toJSON()}));
    return this;  
  }
});

levl.SkillsView = Backbone.View.extend({
  tagName: 'ul',
  
  initialize: function() {
    console.log("initiated")
    this.listenTo(this.model, "sync, add, remove, destroy", this.fetchingSkills);
    this.fetchingSkills();
  },

  fetchingSkills: function(){
    var thisView = this;
    console.log(thisView);
    levl.skills.fetch({
      success: function(model, response){
        console.log(model)
        thisView.template = _.template($('#skill-template').html());
        if(model && model.length){
          thisView.render();
        } else {
          thisView.handleNone();
        }
      },
      error: function(errors){
        console.log(errors)
      } 

    })
  },

  handleNone: function() {
    $('#content-area').append($("<div class='field_with_errors card-panel'><span>There are no skills yet, gain skills by setting up your profile at <a class='white-text' href='http://rescuetime.com'> Rescue Time </a> has not been set up yet.</span></div>"));
  },
  render: function() {
    console.log("rendering!")
    console.log(this);
    var el = this.$el;
    el.empty();
    console.log(this.collection)
    //render a SkillView for each skill
    
    el.append("<h1>Skills</h1>");
    this.collection.each(function(skill) {
      el.append(new levl.SkillView({model: skill}).render().el);
    });

    // add the view to the content-area
    $('#content-area').html(el);
  }
});
  
function skillShow()  {
  console.log("hi ");
  levl.constantView = new levl.UserView({
    model: levl.user
  }); 
}
function initiateViews() {
  levl.currentView = new levl.SkillsView({
    collection: levl.skills
  });
  levl.eventView = new levl.EventsView({
    collection: levl.userEvents
  });
}