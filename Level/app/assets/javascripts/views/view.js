// var UsersView;

$(document).ready(function(){

	SkillView = Backbone.View.extend({
		tagName: 'li',
		template: _.template($('#skill-template').html()),
		render: function(){
			console.log(this.template)
			this.$el.html(this.template({skill: this.model.toJSON()}));
			return this;	
		}
	});

	SkillsView = Backbone.View.extend({
		tagName: 'ul',
		id: 'skills',
		template: _.template($('#skill-template').html()),
		initialize: function() {
			skills.fetch({
        	success: function() {
          	new SkillsView({collection: tweets});
        	}
		}
		render: function() {
      var el = this.$el;
      // remove whatever is in the content-area and the element itself
      $('#content-area').html('');
      el.html('');

      // add a header
      el.append('<h1>Skills for ' + currentUser + '</h1>');

      // render a SkillView for each skill
      this.collection.each(function(skill) {
        el.append(new SkillView({model: skill}).render().el);
      });

      // add the view to the content-area
      $('#content-area').html(el);
      return this;
    }
 
	})

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
});
