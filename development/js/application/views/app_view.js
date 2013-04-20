"use strict";

App.View = Backbone.View.extend({
  el: "#app-root",

  events: {

  },

  initialize: function() {
    _.bindAll(this);
  },

  render: function() {
    var ctx   = this.model.toJSON(),
        html  = App.JST['application'](ctx);

    this.$el.html(html);

    return this;
  }
});
