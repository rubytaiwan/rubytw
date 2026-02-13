$(document).ready(function () {
  // Enable Bootstrap Carousel
  $('.carousel').carousel();

  $(".carousel").swipe({
    swipe: function(event, direction, distance, duration, fingerCount, fingerData) {
      if (direction == 'left') $(this).carousel('next');
      if (direction == 'right') $(this).carousel('prev');
    },
    allowPageScroll: "vertical"
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
  $('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
  });

  // Offset for Main Navigation
  $('#affixNav').affix({
    offset: {
      top: 100
    }
  });

  // Toggle More Blog Posts
  $('.blog-more').click(function() {
    var morePosts = $('.blog.more');
    if ($(this).hasClass('active')) {
      morePosts.css('display', 'none');
      $(this).removeClass('active');
      return;
    }
    morePosts.css('display', 'flex');
    $(this).addClass('active');
  });

  // Toggle Ended Events
  $('.events-more').click(function() {
    var endedEvents = $('.event-card.ended');
    endedEvents.toggle();
    $(this).toggleClass('active');
  });
});
