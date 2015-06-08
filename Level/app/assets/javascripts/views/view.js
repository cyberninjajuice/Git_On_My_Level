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
      if(rescueKey.val().length === 40){
        this.model.save(
        {email: email.val(), rescue_key: rescueKey.val()},
        { success: function(model, response) { 
          thisView.fetchingUser();
          $("div.edit_form").hide();
          $("button.editing_user").show();
        }, error: function(errors){ console.log(errors);}
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

  EventView = Backbone.View.extend({
		tagName: 'li',
		initialize: function(){
      this.template = _.template($('#event-template').html())
    },
		render: function(){
			this.$el.html(this.template({event: this.model.toJSON()}));
			return this;	
		}
	});

	EventsView = Backbone.View.extend({
		tagName: 'ul',
		initialize: function() {
      console.log("passed this "+this.id)
      this.listenTo(this.model, "sync, add, remove, destroy", this.fetchingEvents);
      this.fetchingEvents();
		},

    fetchingEvents: function(){
      //console.log(this)
      thisView = this;
      userEvents.fetch({
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
      el.append("<h1>Events</h1>");
      //console.log(this.collection)
      // render a EventView for each event
      this.collection.each(function(event) {
        el.append(new EventView({model: event}).render().el);
      });

      // add the view to the content-area
      $('#events-area').html(el);
      return this;
    }

	});

  SkillView = Backbone.View.extend({
    tagName: 'li',
    initialize: function(){
      this.template = _.template($('#skill-template').html())
    },
    render: function(){
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
      var thisView = this;
      skills.fetch({
        success: function(model, response){
          console.log(model)
          this.template = _.template($('#skill-template').html());
          //console.log(this.template)
          console.log(thisView.render());
          thisView.render();
        },
        error: function(errors){
          console.log(errors)
        } 

      })
    },

    render: function() {
      console.log("rendering!")
      var el = this.$el;
      el.empty();
      // clear the content-area.
      //$('div#content-area').empty();


      console.log(this.collection)
      //render a SkillView for each skill
      
      el.append("<h1>Skills</h1>");
      this.collection.each(function(skill) {
        el.append(new SkillView({model: skill}).render().el);
      });

      // add the view to the content-area
      $('#content-area').html(el);
      var data = $("#user-chart").first().text();
      console.log(data);
      data = JSON.parse(data)
      console.log(data.length);
      data.map(function(i){
        console.log(i);
      })
      console.log(d3)
      var chart = document.getElementById("chart");
      console.log(chart)
      var axisMargin = 20, margin = 20, valueMargin = 4, width = chart.offsetWidth, height = chart.offsetHeight, barHeight = (height-axisMargin-margin*2)* 0.4/data.length, barPadding = (height-axisMargin-margin*2)* 0.6/data.length, data, bar, svg, scale, xAxis, labelWidth = 0;

      var max = d3.max(data.map(function(i){ 
        return i[1];
      }));
      
      svg = d3.select(chart)
        .append("svg")
        .attr("width", width)
        .attr("height", 400);


      bar = svg.selectAll("g")
        .data(data)
        .enter()
        .append("g");

      bar.attr("class", "bar")
        .attr("cx",0)
        .attr("transform", function(d, i) { 
           return "translate(" + margin + "," + (i * (barHeight + barPadding) + barPadding) + ")";
        });

      bar.append("text")
        .attr("class", "label")
        .attr("y", barHeight / 2)
        .attr("dy", ".35em") //vertical align middle
        .text(function(d){
          return d[0];
        }).each(function() {
          labelWidth = Math.ceil(Math.max(labelWidth, this.getBBox().width));
        });

      scale = d3.scale.linear()
        .domain([0, max])
        .range([0, width - margin*2 - labelWidth]);

      bar.append("rect")
        .attr("transform", "translate("+labelWidth+", 0)")
        .attr("height", barHeight)
        .attr("width", function(d){
          console.log("face");
          
          return scale(d[1]);
        });

      bar.append("text")
        .attr("class", "value")
        .attr("y", barHeight / 2)
        .attr("dx", -valueMargin + labelWidth) //margin right
        .attr("dy", ".35em") //vertical align middle
        .attr("text-anchor", "end")
        .text(function(d){
          return d[1];
        })
        .attr("x", function(d){
          var width = this.getBBox().width;
          return Math.max(width + valueMargin, scale(d[1]));
       });

      svg.insert("g",":first-child")
       .attr("class", "axis")
       .attr("transform", "translate(" + (margin + labelWidth) + ","+ (height - axisMargin - margin)+")")
       .call(xAxis);

      return this;
    }

  });