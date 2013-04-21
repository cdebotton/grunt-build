"use strict";

App.PkgA.View = Backbone.View.extend({
  el: "#app-root",

  events: {

  },

  initialize: function() {
    _.bindAll(this);
  },

  render: function() {
    var ctx   = this.model.toJSON(),
        html  = App.JST['PkgA.root'](ctx);

    this.$el.html(html);

    return this;
  }
});
