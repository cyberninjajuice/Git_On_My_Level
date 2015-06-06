// var UsersView;
console.log("view");
	SkillView = Backbone.View.extend({
		tagName: 'li',
		initialize: function(){
      this.template=_.template($('#skill-template').html())
    },
		render: function(){
			console.log(this.template)
			this.$el.html(this.template({skill: this.model.toJSON()}));
			return this;	
		}
	});

	SkillsView = Backbone.View.extend({
		tagName: 'ul',
		id: 'skills',
		initialize: function() {
      console.log("initiated")
      this.listenTo(this.model, "sync, add, remove, destroy", this.render);
      this.template = _.template($('#skill-template').html());
      this.fetchingSkills();
		},
    fetchingSkills: function(){
      users.fetch({
        success: function(model, response){
          console.log(model) 
        }
      })
    },
		render: function(uid) {
      var el = this.$el;
      // remove whatever is in the content-area and the element itself
      //$('div#content-area').html('');
      console.log(el)
      el.append("<p>hello</p>")
      // add a header
      el.append('<h1>Skills for ' + uid + '</h1>');
      console.log(this.collection)
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
