// JavaScript Document
(function($){
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-67915750-1', 'auto');
    ga('send', 'pageview');

    $(function(){
        $('[megais_ga]').on('click', function(){
            var trackStr = $(this).attr('megais_ga');
            window.trackingEvent(trackStr, "click");
        })
    });

    //window fun
    window.tracking = function(_trackpage){  
        ga('send', 'pageview', '/'+_trackpage);
    }

    window.trackingEvent = function(_trackpage,_action){
        ga('send', 'event', _trackpage, _action);
    }
  
})(jQuery);