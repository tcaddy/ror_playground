// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
var App = window.App || {};
(function($, undefined) {
  App.init = function() {
    console.log('running App.init()');
    Turbolinks.enableProgressBar();
    $("button.close").on('click',function(e){
      $(e.currentTarget).parent().remove();
    });
    console.log('App.init() complete');
  };
  $(document).on('page:change', function(e) {
    App.init();
  });
})(jQuery);