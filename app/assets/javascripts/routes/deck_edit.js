TwoRooms.DeckEditRoute = Ember.Route.extend({
	setupController: function(controller, model) {
		controller.set('cards', this.store.findAll('card'));
		controller.set('model', model);
	},
	actions: {
		save: function() {
			var model = this.get('controller').get('content');
			var self = this;
			model.save().then(function(){
				self.transitionTo('deck');
			}, function(){
				this.get('controller').set('error', 'Unable to save.');
			})
		},
		cancel: function(){
			this.transitionTo('deck');
		}
	}

});
