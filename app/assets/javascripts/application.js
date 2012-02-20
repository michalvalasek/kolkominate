// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  $('input.date_picker').date_input({
  	stringToDate: function(string) {
    var matches;
    if (matches = string.match(/^(\d{2,2})\.(\d{2,2})\.(\d{4,4})$/)) {
      return new Date(matches[3], matches[2] - 1, matches[1]);
    } else {
      return null;
    };
  },
  dateToString: function(date) {
    var month = (date.getMonth() + 1).toString();
    var dom = date.getDate().toString();
    if (month.length == 1) month = "0" + month;
    if (dom.length == 1) dom = "0" + dom;
    return dom + "." + month + "." + date.getFullYear();
  }
  });
});