class VotesController < ApplicationController
  def create
    @post = Post.find_by(params[:post_id])
    if !@post
      flash[:message] = "No such post!"
      redirect_to posts_path
    end

    @vote = current_user.votes.find_or_initialize_by(post: @post)
    if @vote.value && @vote.value == params[:vote][:value].to_i
      @vote.destroy
      flash[:message] = "Unvote Successful!"
    elsif @vote.update(vote_params)
      flash[:message] = "Vote Successful!"
    else
      flash[:message] = "Something went wrong!"
    end
    redirect_to post_path(@post)
  end

  private

  def vote_params
    params.require(:vote).permit(:value)
  end
end
