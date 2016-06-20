(function($) {

	$(function() {
		setHamburger();
		setButton();
		categoryBarFixed();
	});
	function setButton() {
		console.log('common');
		$('.nav-btn').on('click', function() {
			$(this).toggleClass('active');
			$('.nav').slideToggle();
		});
		$('.goTop-btn').on('click', function() {
			$('html, body').animate({
				scrollTop: 0
			}, 1000, 'easeOutQuart');
		});
		$('.category .title').on('click', function() {
			$('.sub').slideUp(function() {
				$(this).css({'display': ''});
			});
			if ( $( '+ .sub', $(this) ).css('display') === 'none' ) {
				$( '+ .sub', $(this) ).slideDown();
			}
		});
	}
	function setHamburger() {
		var forEach=function(t,o,r){if("[object Object]"===Object.prototype.toString.call(t))for(var c in t)Object.prototype.hasOwnProperty.call(t,c)&&o.call(r,t[c],c,t);else for(var e=0,l=t.length;l>e;e++)o.call(r,t[e],e,t)};
	    var hamburgers = document.querySelectorAll(".hamburger");
	    if (hamburgers.length > 0) {
	      forEach(hamburgers, function(hamburger) {
	        hamburger.addEventListener("click", function() {
	          this.classList.toggle("is-active");
	        }, false);
	      });
	    }
	}
	function categoryBarFixed() {
		var j_category = $('.category-area');
		var categoryTop = j_category.offset().top;
		var j_nav = $('.nav');
		var navHeight = $('.nav').height();
		var scrollTop = 0;
		$(window).scroll(function() {
			scrollTop = $(window).scrollTop();
			if (j_nav.css('display') === 'none') {
				navHeight = 0;
			} else {
				navHeight = $('.nav').height();
			}
			if (scrollTop >= categoryTop + navHeight) {
				j_category.css({
					'position': 'fixed'
				});
			} else {
				j_category.css({
					'position': 'relative'
				});
			}
		}).scroll();
	}
})(jQuery);