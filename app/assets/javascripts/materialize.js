$(document).ready(function() {
  $('select').material_select();
  $('.slider').slider({
    height: 650
  });
  $(".button-collapse").sideNav();
});

$(document).on('turbolinks:load', function() {
  $(".dropdown-button").dropdown();
  $(".button-collapse").sideNav();
  $('.collapsible').collapsible();
})
