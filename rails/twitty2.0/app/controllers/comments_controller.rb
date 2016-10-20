class CommentsController < ApplicationController

  def create
    @twit = Twit.find(params[:twit_id])
    @comment = @twit.comments.create(comment_params)
    @comment.save
    redirect_to twit_path(@twit)
  end

  def destroy
    @twit = Twit.find(params[:twit_id])
    @comment = @twit.comments.find(params[:id])
    @comment.destroy
    redirect_to twit_path(@twit)
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :body, :twit_id)
    end
end
