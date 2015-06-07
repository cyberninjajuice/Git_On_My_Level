// var UsersView;
console.log("view");
  //Single View for a User Only one that Backbone should deal with.
	UserView = Backbone.View.extend({
    tagName: 'div',
    initialize: function(){
      this.listenTo(this.model, "sync, add, remove, destroy", this.fetchingSkills);
      this.fetchingUser()
    },  
    
    fetchingUser: function() {
      console.log("Fetching user");
      thisView= this;

      console.log(this)
      console.log(user);
      user.fetch({
        success: function(model, response){
          console.log(model)
          thisView.render(thisView.id)
        }, 
        error: function(){
          console.log(people)
        }
      })
    },
    
    render: function(uid){
      this.template= _.template($('#user-template').html())
      this.$el.empty();
      console.log("showing");
      this.$el.html(this.template({skill:this.model.toJSON()}))
      $('#user-area').html(el);
      return this;

    }
  });

  SkillView = Backbone.View.extend({
		tagName: 'li',
		initialize: function(){
      this.template= _.template($('#skill-template').html())
    },
		render: function(){
			//console.log(this.template)
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
      thisView=this;
      skills.fetch({
        success: function(model, response){
          console.log(model)
          this.template = _.template($('#skill-template').html());
          thisView.render(thisView.id)
        }
      })
    },
		render: function() {
      var el = this.$el;
      // remove whatever is in the content-area and the element itself
      //$('div#content-area').html('');
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
