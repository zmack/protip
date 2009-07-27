( function() {

  function simpleLinks(h){
    h = h.replace(/(http:\/\/[^ ]+)/g, "<a href=\"$1\">$1</a>");
    h = h.replace(/(^| )@(\w+)/g, " <a href=\"http://twitter.com/$2\">@$2</a>");
    h = h.replace(/(^| )#(\w+)/g, " <a href=\"http://search.twitter.com/search?q=%23$2\">#$2</a>");

    return h
  }

  // If jQuery is included in the page, adds a jQuery plugin to handle it as well
  if ( typeof jQuery != "undefined" ) {
    jQuery.fn.simpleLinks = function(){
      return this.each(function(){
        if ( this.linkified === undefined ) {
          var links = simpleLinks(this.innerHTML);
          jQuery(this).html(links);
          this.linkified = true;
        }
      });
    }
  }

})();
