class V1::VideosController < V1::BaseController

    after_filter :only => [:index] {set_pagination(:videos)}


	def index


			page = params[:page] ? params[:page] : 1
		    per_page = Settings.pagination_count.video_index
		    
		    @videos = Video.criteria
		    @videos = @videos.where(public: true).active

		    @videos = current_user.favorite_videos if params[:favorite] == 'true'
		     
		    @videos = @videos.tagged_with(params[:tag]) unless params[:tag].blank?
		    @videos = @videos.where(name:  /#{params[:search_term]}/i) unless params[:search_term].blank?   #i is case insensitve

		    @videos = @videos.desc(:created_at) if params[:sort] == 'created_at' || params[:sort].blank?
		    @videos = @videos.desc(:favorite_count) if params[:sort] == 'fav_count'		    
		    @videos = @videos.desc(:hotness)  if params[:sort] == 'hotness'
		    @videos = @videos.asc(name: 1)  if params[:sort] == 'name'

		    @videos = @videos.page(page).per(per_page)

			render :json => @videos,  root: false 

	end




	def show

		 @video = Video.find(params[:id])
   		 @video.inc(:view_counter, 1)
   		 @video.save  #need to run callbacks, eg. hotness


   		 if video
   		 	render :json => @video
   		 else
 	     	render nothing: true, status: 404
 	     end
  		 	
    
	end



	def update


		 @video = Video.find(params[:id])

   		 authorize_action_for(@video)

   		 video.assign_attributes(params[:search])

	     if @video.save
	        render json: @video
	     else
	     	render nothing: true, status: 500
	     end

	end




  def destroy

		 @video = Video.find(params[:id])

   		 authorize_action_for(@video)


   		 @video.deleted = true

	     if @video.save
	        render nothing: true
	     else
	     	render nothing: true, status: 500
	     end


  end







end