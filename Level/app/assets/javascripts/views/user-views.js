var UsersView;

$(document).ready(function(){

	// View for single user
	UsersView = Backbone.View.extend({
		tagName: 'li',
		template: _.template($('#user-template').html()),
	// Future click event for particular user skill
		// events: {'click .skill': 'rescueData'},
	// Gets resuce time information
		rescueData: function() {

			var rescue = this.model.user;
			rescue.fetch({
				success: function(){
					new RescueView({collection: user})
				}
			});
		},

		// render the UserView
		render: function() {
			this.$el.html(this.template({user: this.model.toJSON()}));
			return this;
		}
	});
	});
