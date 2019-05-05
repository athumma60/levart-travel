class ReviewsController < ApplicationController

	#Defines create
	def create
		@review = current_user.reviews.create(review_params)
		redirect_to @review.room
	end

	#Defines destroy
	def destroy
		@review = Review.find(params[:id])
		room = @review.room
		@review.destroy

		redirect_to room
	end

  private
  #Defines review parameters
    def review_params
    	params.require(:review).permit(:comment, :star, :room_id)
    end
end