(function($) {
	$(function() {
		var pageName = $('body').prop('class');
		if ( pageName === "merchandises-index" ) {
			showList();
			setButton();
			// merchandiseFilter();
		}
	});
	function setButton() {
		
	}
	function showList() {
		var categoriesJSON;
		var merchandisesJSON;
		$.ajax({
			url: "http://json2jsonp.com/?url=https://ririkoko.herokuapp.com/api/merchandises?api_key=e813852b6d35e706f776c74434b001f9",
			dataType: "jsonp",
			success: function(data) {
				var html = "";
				merchandisesJSON = data;

				// for(var i = 0; i < merchandisesJSON.merchandises.length; i++) {
				// 	html += "<li class=\"product-list\">";
				// 	html += "<a href=\"https://ririkoko.herokuapp.com/merchandises/" + merchandisesJSON.merchandises[i].id + "\">";
    //       html += "<div class=\"product-img\">";
    //       html += "<img src=" + merchandisesJSON.merchandises[i].image1_url_m + ">";
    //       html += "</div>";
    //       html += "<div class=\"product-info\">";
    //       html += "<p class=\"name\">" + merchandisesJSON.merchandises[i].title +"</p>";
    //       html += "<p class=\"price\">" + merchandisesJSON.merchandises[i].price + "</p>";
    //       html += "</div>";
    //       html += "</a>";
    //       html += "<div class=\"mask\">";
    //       html += "<div class=\"addToCart\">";
    //       html += "<a href=\"https://ririkoko.herokuapp.com/merchandises/" + merchandisesJSON.merchandises[i].id + "\">view</a>";
    //       html += "</div>";
    //       html += "</div>";
    //       html += "</li>";
				// }

				// $('#products .content').append(html);
				
				getCategories();
			}
		});
		
		function getCategories() {
			$.ajax({
				url: "http://json2jsonp.com/?url=https://ririkoko.herokuapp.com/api/categories?api_key=e813852b6d35e706f776c74434b001f9",
				dataType: "jsonp",
				success: function(data) {
					var myCategories;
					var myCategoriesArr = [];
					var html = "";
					var filterItem;
					var name;
					categoriesJSON = data;
					for(var i = 0; i < merchandisesJSON.merchandises.length; i++) {
						for(var j = 0; j < categoriesJSON.categories.length; j++) {
							if (categoriesJSON.categories[j].id == merchandisesJSON.merchandises[i].category_id) {
								myCategories = categoriesJSON.categories[j];
								myCategoriesArr.push(myCategories);
							}
						}

						merchandisesJSON.merchandises[i].categoriesName = myCategories.name;
						name = removeAllSpace(merchandisesJSON.merchandises[i].categoriesName).replace(/&/g, "").replace(/'/g, "");
						$('#products .content li').eq(i).addClass(name);
						filterItem = "<li data-filter=\"." + name + "\">" + merchandisesJSON.merchandises[i].categoriesName + "</li>"
						$('#product-filter .filter-item').append(filterItem);
						merchandiseFilter();
						$('.filter-item li').eq(0).click().click();
						$('#products').animate({
							'opacity': 1
						}, 1000);
					}
				}
			});
		}
	}
	function removeAllSpace(str) {
	  return str.replace(/\s+/g, "");
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
      // var filterValue = $( this ).text();
      // console.log('filterValue = ', filterValue);
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
	    // console.log('this.width = ', this.width);
	    
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
	    // console.log('_masonryResizeChanged = ', prevColCount);
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
	    // console.log('_masonryGetContainerSize');
	    
	    return {
	        height : Math.max.apply( Math, this.masonry.colYs ),
	        // fit container to columns that have been used;
	        width : (this.masonry.cols - unusedCols) * this.masonry.columnWidth
	    };
		};
	}
})(jQuery);