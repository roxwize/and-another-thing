class PagesController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def explore
    @blogs = Blog.order('updated_at DESC').limit(25)
  end

  def viewblog
    @blog = Blog.find_by(id: params[:id])
    @posts = @blog.posts.order('created_at DESC')
    if @blog.nil?
      redirect_to root_path, alert: "Blog not found! It may have been deleted or moved."
    end
  end

  def viewpost
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to root_path, alert: "Post not found! It may have been deleted or moved."
    end
  end
end