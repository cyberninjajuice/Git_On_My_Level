
console.log("view");
  //Single View for a User Only one that Backbone should deal with.

	levl.UserView = Backbone.View.extend({
    tagName: 'div',
    initialize: function(){
      this.listenTo(this.model, "sync, add, remove, destroy, update", this.fetchingSkills);
      this.fetchingUser()
    },
    events: {
      "click .editing_user": "editForm",
      "click button.update_user": "updateIt"
    },
    
    editForm: function() {
      $("div.edit_form").show();
      $("button.editing_user").hide();
    },

    updateIt: function(){
      var email = $("#email")
      var rescueKey = $("#rescue-key")
      var thisView = this;
      console.log(this.model)
      if(rescueKey.val().length === 40){
        this.model.save(
        {email: email.val(), rescue_key: rescueKey.val()},
        { success: function(model, response) { 
          thisView.fetchingUser();
          $("div.edit_form").hide();
          $("button.editing_user").show();
        },
         error: function(errors){ console.log(errors);}
        },
        { patch: true }
        )
      } else {
        this.model.save(
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
        
        )
      }
    },

    fetchingUser: function() {
      //console.log("Fetching user");
      var thisView= this;
      //console.log(thisView)

      var specifyTemp = $('#userTemp').html();
      this.template = _.template(specifyTemp)
      levl.user.fetch({
        success: function(model, response){
          //console.log(model)
          this.model= model;

          thisView.render(thisView.id, model);
        }, 
        error: function(){
          console.log("people error")
        }
      });
      return this;
    },
    
    render: function(uid){
      console.log("showing" + this.model);
      var temp = this.template;
      console.log(temp)
      
      var el = this.$el;
      el.empty();
      
      el.html(temp({user: this.model.toJSON()}) )
      $('#user-area').html(el);
      this.delegateEvents();
      return this;

    }
  });

  levl.EventView = Backbone.View.extend({
		tagName: 'li',
		initialize: function(){
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
      console.log("passed this "+this.id)
      this.listenTo(this.model, "sync, add, remove, destroy", this.fetchingEvents);
      this.fetchingEvents();
		},

    fetchingEvents: function(){
      //console.log(this)
      thisView = this;
      levl.userEvents.fetch({
        success: function(model, response){
          //console.log(model)
          this.template = _.template($('#event-template').html());
          thisView.render(thisView.id)
        },
        error: function(errors){
          console.log(errors)
        } 

      })
    },
		render: function() {
      var el = this.$el;
      //clear the content-area.
      //$('div#content-area').empty();
      console.log("rendering events")
      el.empty();
      el.append("<h3>Events</h3>");
      //console.log(this.collection)
      // render a EventView for each event
      this.collection.each(function(event) {
        el.append(new levl.EventView({model: event}).render().el);
      });

      // add the view to the content-area
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
          
          thisView.render();
        },
        error: function(errors){
          console.log(errors)
        } 

      })
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
      //console.log(d3)
    }
  });

 skillShow = function() {
    console.log("hi ")
    // skills.fetch({
    //   success: function(){
      console.log(levl.user)
    levl.constantView = new levl.UserView({
      model: levl.user,
      // id: user_id
    }) 
    levl.currentView = new levl.SkillsView({
        collection: levl.skills,
        // id: user_id
    })
    levl.eventView = new levl.EventsView({
      collection: levl.userEvents,
      // id: user_id
    })
  }