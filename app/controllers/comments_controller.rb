class CommentsController < ApplicationController

  before_action :login_test

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "New comment was created."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    Vote.create(vote: params[:vote], creator: current_user, voteable: @comment)

    respond_to do |res|
      res.html {redirect_to :back}
      res.js
    end
    
  end

end