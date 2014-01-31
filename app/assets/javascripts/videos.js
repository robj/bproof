Videos = Backbone.PageableCollection.extend({

  model: Video,
  url: "/v1/videos",
  mode: 'infinite',


  queryParams: {

  	 pageSize: null,
     totalPages: null,
	 totalRecords: null,
  
  }


});



function addVideosToResultsGrid() {



	videos.each(function(video) { 

		$('#video-grid').append( HoganTemplates.video.render(video.attributes) )

	});


}


function buildAndSubmitVideoSearch() {
	
	tag = 	$("#videos-filter option:selected").first().val()
	sort = 	$("#videos-sort option:selected").first().val()
	favorite = $('#videos-fav-button').data('active')
	search_term = $('#videos-search-term').val()
	

	data = { data: { favorite: favorite, sort: sort, tag: tag, search_term: search_term }} 
		
	videos = new Videos;	
	videos.getFirstPage(data).success(function() { 

		$('#video-grid').empty();
		addVideosToResultsGrid();

	})



	
}


function initVideos() {



	videos.getFirstPage().success(function() { 
			addVideosToResultsGrid();
	});





	$('.selectpicker').selectpicker();
	$('#video-search-filter-bar').show();
	

	$('#videos-fav-button').click(function() {
		
		if ($(this).data('active') == false) {
			
			$(this).data('active',true)
			$(this).css('color', '#FF9966');
			buildAndSubmitVideoSearch() 
			
			
			
		 }
		
		else  {
			
			$(this).data('active',false)
			$(this).css('color', '#868686');
			buildAndSubmitVideoSearch() 
			
			
		}
		
		
	})
	
	

	$('#videos-sort').change(function() { 
		
		buildAndSubmitVideoSearch() 

	});
	
	
	$('#videos-filter').change(function() { 
		
		buildAndSubmitVideoSearch() 

	});
	
	
	$('#videos-search-term').keypress(function(e){
		if(e.which == 13){
			
			buildAndSubmitVideoSearch() 
			
		}
		
	});















	
	




		  loading = false;
		  function nearBottomOfPage() {

	
			return $(window).scrollTop() > $(document).height() - $(window).height() - 640;
    
		  }

		  $(window).scroll(function(){
		    if (loading) {
		      return;
		    }


		    if(nearBottomOfPage() && videos.hasNext() ) {
		      loading=true;


			  $('.sausage-pagination-spinner').spin();

			 	videos.getNextPage().success(function() {

			 	  			addVideosToResultsGrid()

		         	 loading=false;

				 	$(".sausage-pagination-spinner").spin(false)
		        })
		     

		     }
		  

		  });

	
	
	
	}
