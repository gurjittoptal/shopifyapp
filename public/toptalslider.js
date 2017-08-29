  (function(){
    // load slidercss
    var ls = document.createElement('link');
    ls.rel="stylesheet";
    ls.href="//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css";
    document.getElementsByTagName('head')[0].appendChild(ls);
    
    var loadScript = function(url, callback){
    var script = document.createElement("script");
    script.type = "text/javascript";

    // If the browser is Internet Explorer.
    if (script.readyState){ 
      script.onreadystatechange = function(){
        if (script.readyState == "loaded" || script.readyState == "complete"){
          script.onreadystatechange = null;
          callback();
        }
      };
    // For any other browser.
    } else {
      script.onload = function(){
        callback();
      };
    }

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
   };


  var myAppJavaScript = function($){
    
    $.getScript( "//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js", function( data, textStatus, jqxhr ) {
    //$.getScript( "https://tpshp.herokuapp.com/css/sss.css", function( data, textStatus, jqxhr ) {
      console.log( "Load was performed." );
       
      $.get( "/a/proxy/toptalsliderproduct", function( data ) {
       
        $.each(data,function(i,prod) {
    	   if(prod.hasOwnProperty('src')){ 
             var pimg = $('<img>');
             pimg.attr('src',prod.src);
             pimg.attr('title',prod.title);
             pimg.appendTo('.toptal-slider');
	  }});
          
          //$('.toptal-slider').sss();
          $('.toptal-slider').slick();
          console.log(data.length);
        });
     //});
     });

   };

  if ((typeof jQuery === 'undefined') || (parseFloat(jQuery.fn.jquery) < 1.7)) {
    loadScript('//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js', function(){
      jQuery191 = jQuery.noConflict(true);
      myAppJavaScript(jQuery191);
    });
  } else {
    myAppJavaScript(jQuery);
  }

  })();
