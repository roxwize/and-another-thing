class UserController < ApplicationController
  before_action :authenticate_user!

  def dashboard

  end

  def editblog
    @blog = current_user.blog
  end
  def finaliseeditblog
    current_user.blog.update(blog_params)
    redirect_to dashboard_path, notice: "Your blog has been edited."
  end

  def upvoteblog
    @blog = Blog.find_by(id: params[:id])
    if @blog.user == current_user
      redirect_to blog_view_path(id: @blog.id), alert: "Erm, that's your blog."
      return
    end
    if @blog.kudos.nil? or not @blog.kudos.any? or not Kudo.find_by(user_id: current_user.id, blog_id: @blog.id).present?
      kudo = Kudo.new(user: current_user, blog: @blog)
      if kudo.save
        redirect_to blog_view_path(id: @blog.id), notice: "Upvoted!"
      else
        redirect_to blog_view_path(id: @blog.id), alert: "An unknown error occurred."
      end
    else
      redirect_to blog_view_path(id: @blog.id), alert: "You already upvoted that blog."
    end
  end

  def makeblog
    @blog = Blog.new
  end
  def finalisemakeblog
    @blog = Blog.new blog_params
    @blog.user = current_user
    if @blog.save
      redirect_to dashboard_path, notice: "Your blog has been created!"
    else
      render :makeblog
    end
  end

  def makepost
    @post = Post.new
  end

  def finalisemakepost
    @post = Post.new post_params
    @post.blog = current_user.blog
    if @post.save
      redirect_to blog_view_path(id: current_user.blog.id), notice: "Your post has been created!"
    else
      render :makepost
    end
  end

  def editpost
    @post = Post.find_by(id: params[:id])
    if current_user != @post.blog.user
      redirect_to blog_post_path(id: @post.id), alert: "You don't own that post!"
    end
  end

  def finaliseeditpost
    @post = Post.find_by(id: params[:id])
    @post.update(post_params)
    redirect_to blog_view_path(id: @post.blog.id), notice: "Your post has been edited."
  end

  def makecomment
    @comment = Comment.new
    @post = Post.find_by(id: params[:id])
  end

  def finalisemakecomment
    @comment = Comment.new comment_params
    @post = Post.find_by(id: params[:id])
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to blog_post_path(id: @post.id), notice: "Your comment has been added!"
    else
      render :makecomment
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:name)
  end
  def post_params
    params.require(:post).permit(:title, :content)
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
  # def serialise(post)
  #   doc = Nokogiri::HTML.fragment(post)
  #   doc.css('script,iframe,link,input,button,meta,title,head,body,html').each do |el|
  #     el.replace(CGI.escapeHTML(el))
  #   end
  #   doc.to_html
  # end
end