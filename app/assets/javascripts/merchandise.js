(function($) {
	$(function() {
		slider();
		merchandiseFilter();
		setButton();
	});
	function setButton() {
		$('.filter-item li').eq(0).click().click();
		// $('.filter-item').css({
	 //    'visibility': 'hidden'
		// }).attr('style', '');

		$('.category .title').on('click', function() {
			$('.sub').slideUp(function() {
				$(this).css({'display': ''});
			});
			if ( $( '+ .sub', $(this) ).css('display') === 'none' ) {
				$( '+ .sub', $(this) ).slideDown();
			}
		});
	}
	function slider() {
		var index = 0,
				j_sliderBar = 0,
				j_slider = $('.slider'),
				j_slider_content = j_slider.find('.slider-content'),
				j_slider_ul = j_slider_content.find('ul'),
				j_slider_li = j_slider_ul.find('li'),
				j_slider_li_width = j_slider.width(),
				j_slider_li_length = j_slider_li.length;

		j_slider.append('<ul class="sliderBar"></ul>');
		j_sliderBar = $('.sliderBar');
		for (i = 0; i < j_slider_li.length; i++){
				j_sliderBar.append('<li></li>');
		}
		j_sliderBar_li = j_sliderBar.find('li');

		j_sliderBar_li.eq(index).addClass('active');
		j_sliderBar_li.click(function(){
			index = $(this).index();

			j_slider_ul.stop().animate({left: -index * j_slider_li_width }, 800, 'easeOutQuart');
			$(this).addClass('active').siblings('li').removeClass('active');
			console.log('index = ', index);
		});
		$('.next').on('click', function() {
			index++;
			if (index > j_slider_li_length - 1) {
				index = 0;
			}
			j_sliderBar_li.eq(index).addClass('active').siblings('li').removeClass('active');
			j_slider_ul.stop().animate({left: -index * j_slider_li_width }, 800, 'easeOutQuart');
		});
		$('.prev').on('click', function() {
			index--;
			if (index < 0) {
				index = j_slider_li_length - 1;
			}
			j_sliderBar_li.eq(index).addClass('active').siblings('li').removeClass('active');
			j_slider_ul.stop().animate({left: -index * j_slider_li_width }, 800, 'easeOutQuart');
		});
		$(window).resize(function() {
			j_slider_li_width = $(window).width();
			j_slider_li.width( j_slider_li_width );
			j_slider_ul.stop().animate({left: -index * j_slider_li_width }, 0, 'easeOutQuart');
		}).resize();
	}
	function merchandiseFilter() {
		var j_html = $('html');

		j_html.on('click', '.filter-group', function(e) {
			e.preventDefault();
			$(this).toggleClass('is-open');
		});

		j_html.on('click', '.filter-group li', function(e) {
			e.preventDefault();
			var j_item = $(this);
			var j_select = $('.filter-select');
			j_select.text(j_item.text());
		});

		j_html.on('click', function(e) {
			var j_target = $(e.target);
			if ( !j_target.parents().hasClass('filter-group') ) {
				$('.filter-group').removeClass('is-open');
			}
		})


		// init Isotope
    var $grid = $('#products').isotope({
      itemSelector: '.product-list',
      // filter: '*',
      layoutMode: 'masonry',
      masonry: {
			  columnWidth: 0,
			  isFitWidth: true
			}
    });
    // bind filter button click
    $('.filter-group li').on( 'click', function() {
      var filterValue = $( this ).attr('data-filter');
      console.log('filterValue = ', filterValue);
      // use filterFn if matches value
      // filterValue = filterFns[ filterValue ] || filterValue;
      $grid.isotope({ filter: filterValue });
    });
    // change is-checked class on buttons
    $('.filter-group li').on( 'click', function() {
        $('.filter-group li').removeClass('active');
        $( this ).addClass('active');
    });

    jQuery.Isotope.prototype._getCenteredMasonryColumns = function() {
	    this.width = this.element.width();
	    console.log('this.width = ', this.width);
	    
	    var parentWidth = this.element.parent().width();
	    
	    // i.e. options.masonry && options.masonry.columnWidth
	    var colW = this.options.masonry && this.options.masonry.columnWidth ||
	        // or use the size of the first item
	        this.$filteredAtoms.outerWidth(true) ||
	        // if there's no items, use size of container
	        parentWidth;
	    
	    var cols = Math.floor( parentWidth / colW );
	    cols = Math.max( cols, 1 );
	    
	    // i.e. this.masonry.cols = ....
	    this.masonry.cols = cols;
	    // i.e. this.masonry.columnWidth = ...
	    this.masonry.columnWidth = colW;
		};

		jQuery.Isotope.prototype._masonryReset = function() {
	    // layout-specific props
	    this.masonry = {};
	    // FIXME shouldn't have to call this again
	    this._getCenteredMasonryColumns();
	    var i = this.masonry.cols;
	    this.masonry.colYs = [];
	    while (i--) {
	        this.masonry.colYs.push( 0 );
	    }
		};

		jQuery.Isotope.prototype._masonryResizeChanged = function() {
	    var prevColCount = this.masonry.cols;
	    // get updated colCount
	    this._getCenteredMasonryColumns();
	    console.log('_masonryResizeChanged = ', prevColCount);
	    return ( this.masonry.cols !== prevColCount );
	  };

	  jQuery.Isotope.prototype._masonryGetContainerSize = function() {
	    var unusedCols = 0,
	        i = this.masonry.cols;
	    // count unused columns
	    while ( --i ) {
	        if ( this.masonry.colYs[i] !== 0 ) {
	            break;
	        }
	        unusedCols++;
	    }
	    console.log('_masonryGetContainerSize');
	    
	    return {
	        height : Math.max.apply( Math, this.masonry.colYs ),
	        // fit container to columns that have been used;
	        width : (this.masonry.cols - unusedCols) * this.masonry.columnWidth
	    };
		};
	}
})(jQuery);