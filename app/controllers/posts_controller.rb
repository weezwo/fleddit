class PostsController < ApplicationController
  before_action :set_post, :redirect_if_post_nonexistent!, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_authorized!, only: [:edit, :update, :destroy]
  
  def index
    if params[:user_id]
      if set_user
        @nested = true
        @user = User.find_by(id: params[:user_id])
        @posts = @user.authored_posts
      else
        flash[:message] = "User Does Not Exist!"
        redirect_to root_path
      end
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.authored_posts.build(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @vote = Vote.new
    @vote_total = @post.votes.sum(&:value)
    @user_vote = Vote.find_by(user: current_user, post: @post)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:message] = "Post Successfully Updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:message] = "Post Successfully Destroyed!"
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def redirect_if_post_nonexistent!
    if @post.nil?
      flash[:message] = 'Post Does Not Exist!'
      redirect_to posts_path
    end
  end

  def redirect_if_user_nonexistent!
    if @user.nil?
      flash[:message] = 'Post Does Not Exist!'
      redirect_to posts_path
    end
  end

  def redirect_if_not_authorized!
    if @post.user != current_user
      redirect_to '/posts'
    end
  end
end
