// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require turbolinks
//= require jquery.easing
//= require jquery-touchswipe/jquery.touchSwipe.min
//= require_tree .

$(function(){

  // Enable Bootstrap Carousel
  $('.carousel').carousel()

  $(".carousel").swipe({
    swipe: function(event, direction, distance, duration, fingerCount, fingerData) {
      if (direction == 'left') $(this).carousel('next');
      if (direction == 'right') $(this).carousel('prev');
    },
    allowPageScroll:"vertical"
  });

  // jQuery for page scrolling feature - requires jQuery Easing plugin
  $('a.page-scroll').bind('click', function(event) {
      var $anchor = $(this);
      $('html, body').stop().animate({
          scrollTop: ($($anchor.attr('href')).offset().top - 57)
      }, 1000, 'easeInOutExpo');
      event.preventDefault();
  });

  // Highlight the top nav as scrolling occurs
  $('body').scrollspy({
      target: '.navbar-fixed-top',
      offset: 60
  });

  // Closes the Responsive Menu on Menu Item Click
  $('.navbar-collapse ul li a').click(function(){ 
     $('.navbar-toggle:visible').click();
  });

  // Offset for Main Navigation
  $('#mainNav').affix({
    offset: {
      top: 100
    }
  })

  // Toggle News Modal Box
  $('.news-title').click(function(e){
    e.preventDefault();
    newsModal = $(this).attr("data-modal");
    $("#" + newsModal).fadeToggle( 100, "linear" );
    $("body").addClass("modal-open");
  });

  $(".modal-close, .modal-sandbox").click(function(){
    $(".news-modal").fadeToggle( 80, "linear" );
    $("body").removeClass("modal-open")
  });

  // Toggle Ended Events
  $('.events-more').click(function(e){
    e.preventDefault();
    var endedEvents = $('.event-card.ended');
    endedEvents.toggle();
    $(this).toggleClass( "active" )
  });
});