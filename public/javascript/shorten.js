$(document).ready(function() {
  $('textarea').focus(function() {
		$(this).innerHTML('');
  });
});