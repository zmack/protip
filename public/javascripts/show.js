( function() {

  $(document).keydown( function(e) {
    switch( e.keyCode ) {
      case 74:
        voteDown();
      break;

      case 75:
        voteUp();
      break
    }
  })
  
  function insertNewTweet(e) {
    $('ul.twit').html(e);
    $('span.date').prettyDate();
  }

  function getNextTweet() {
    $.get('/random', null, insertNewTweet, 'text');
  }

  function voteUpAnimation(e) {
    $('ul.twit li').animate({ top: "-100px", opacity: 0 }, getNextTweet);
  }

  function voteDownAnimation(e) {
    $('ul.twit li').animate({ top: "100px", opacity: 0 }, getNextTweet);
  }

  function voteUp() {
    var addr = $('ul.twit li a.vote_up').attr('href');

    $.post(addr, '_method=put&authenticity_token=' + encodeURIComponent(AUTH_TOKEN), voteUpAnimation, 'json');
  }

  function voteDown() {
    var addr = $('ul.twit li a.vote_down').attr('href');

    $.post(addr, '_method=put&authenticity_token=' + encodeURIComponent(AUTH_TOKEN), voteDownAnimation, 'json');
  }

})();


