$(function() {
  $('span.date').prettyDate();
  $('ul.twit li p .content, ul.twits li p .content').simpleLinks();

  $('.actions .vote_up').click(function() {
    var addr = $(this).attr('href');
    var self = this;
    $.post(addr, '_method=put&authenticity_token=' + encodeURIComponent(AUTH_TOKEN), function() { updateRating(self, 1) }, 'json');
    return false;
  });

  $('.actions .vote_down').click(function() {
    var addr = $(this).attr('href');
    var self = this;
    $.post(addr, '_method=put&authenticity_token=' + encodeURIComponent(AUTH_TOKEN), function() { updateRating(self, -1) }, 'json');
    return false;
  });

  function updateRating(element, delta) {
    var container = $(element).parents('li');
    $(container).find('span.rating').each(
      function(i,k) {
        $(k).html(parseInt(k.innerHTML,10) + delta)
      }
    )

    $(container).find('span.votes').each(
      function(i,k) {
        $(k).html(parseInt(k.innerHTML,10) + 1)
      }
    )
  }

})
