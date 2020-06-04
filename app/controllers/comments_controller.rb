class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @micropost
    else
      flash[:danger] = "コメントを投稿できませんでした。"
      redirect_to @micropost
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    comment = Comment.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    comment.destroy
    redirect_to @micropost
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
