$(function() {
  $('span.date').prettyDate();
  $('ul.twit li p .content, ul.twits li p .content').simpleLinks();

  $('body').click(function(e) {
    var target = $(e.target);

    if ( !target.hasClass('vote_up') && !target.hasClass('vote_down') ) {
      return;
    }
    
    var addr = target.attr('href');
    
    if ( target.hasClass('vote_up') ) {
      var delta = 1;
    } else {
      var delta = -1;
    }
    $.post(addr, '_method=put&authenticity_token=' + encodeURIComponent(AUTH_TOKEN), function() { updateRating(target, delta) }, 'json');
    return false;
  });

  $('.more').click( function() {
    getMoreTweets();
    return false;
  });

  function addNewTweets(e) {
    $('ul.twits').append(e);
    $('span.date').prettyDate();
    $('ul.twit li p .content, ul.twits li p .content').simpleLinks();
  }

  function getMoreTweets() {
    $.get('', "offset=" + $('ul.twits li').length, addNewTweets, 'text');
  }

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
