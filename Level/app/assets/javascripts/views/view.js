// var UsersView;
console.log("view");
  //Single View for a User Only one that Backbone should deal with.
	UserView = Backbone.View.extend({
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
      if(rescueKey.val().length===40){
        this.model.save(
        {email: email.val(), rescue_key: rescueKey.val()},
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
      else{
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
      console.log("Fetching user");
      var thisView= this;

      //console.log(thisView)
      //console.log(user);
      var specifyTemp = $('#userTemp').html();
      this.template = _.template(specifyTemp)
      user.fetch({
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

  SkillView = Backbone.View.extend({
		tagName: 'li',
		initialize: function(){
      this.template = _.template($('#skill-template').html())
    },
		render: function(){
			var temp= this.template
      console.log(temp)
			this.$el.html(this.template({skill: this.model.toJSON()}));
			return this;	
		}
	});

	SkillsView = Backbone.View.extend({
		tagName: 'ul',
		initialize: function() {
      console.log("initiated")
      // console.log("passed this "+this.id)
      this.listenTo(this.model, "sync, add, remove, destroy", this.fetchingSkills);
      this.fetchingSkills();
		},
    fetchingSkills: function(){
      //console.log(this)
      thisView = this;
      skills.fetch({
        success: function(model, response){
          console.log(model)
          this.template = _.template($('#skill-template').html());
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
      //console.log(el)
      el.empty();
      // add a header
      //el.append('<h1>Skills for ' + uid + '</h1>');
      //console.log(this.collection)
      // render a SkillView for each skill
      this.collection.each(function(skill) {
        el.append(new SkillView({model: skill}).render().el);
      });

      // add the view to the content-area
      $('#content-area').html(el);
      return this;
    }

	});


	// // View for single user
	// UsersView = Backbone.View.extend({
	// 	tagName: 'ul',
	// 	template: _.template($('#user-template').html()),
	// // Future click event for particular user skill
	// 	// events: {'click .skill': 'rescueData'},
	// // Gets resuce time information
	// 	userShow: function() {

	// 		var rescue = this.model.user;
	// 		rescue.fetch({
	// 			success: function(){
	// 				new UserView({collection: skill})
	// 			}
	// 		});
	// 	},

		// render the UserView
	// 	render: function() {
	// 		this.$el.html(this.template({user: this.model.toJSON()}));
	// 		return this;
	// 	}

	// });
