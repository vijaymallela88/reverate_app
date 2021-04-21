class PostsController < ApplicationController
  def index
  	user_posts = UserPost.where(:user_id => current_user.id).pluck(:post_id)
    @posts = Post.where(:id => user_posts)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @users = User.where.not(:id => current_user.id)
  end

  def create
    @post = Post.new(post_params)
    user_ids = params[:user_ids].values
    user_ids.push(current_user.id)
    if @post.save
      user_ids.each do |user|
      	user_post = UserPost.find_by(:user_id => user.to_i, :post_id => @post.id)
      	if !user_post.present?
      		UserPost.new(:user_id => user.to_i, :post_id => @post.id, :created_by => current_user.id).save
      	end
      end
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(:id => params[:id])
    @users = User.where.not(:id => current_user.id)
  end

  def update
    @post = Post.find_by(:id => params[:id])
    user_ids = params[:user_ids].values
    user_ids.push(current_user.id)
    if @post.update(post_params)
      user_ids.each do |user|
      	user_post = UserPost.find_by(:user_id => user.to_i, :post_id => @post.id)
      	if !user_post.present?
      		UserPost.new(:user_id => user.to_i, :post_id => @post.id, :created_by => current_user.id).save
      	else
      		user_post.update(:user_id => user.to_i, :post_id => @post.id, created_by => current_user.id)
      	end
      end
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find_by(:id => params[:id])
    post.destroy
     redirect_to posts_path
  end

  private
  def post_params
  	params.require(:post).permit!
  end
end
