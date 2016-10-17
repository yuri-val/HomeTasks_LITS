class CommentsController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    par = params.to_unsafe_h
    par.delete("controller")
    par.delete("action")
    @comments = Comment.all.where(par)
  end


  def create
    @twit = Twit.find(params[:twit_id])
    @comment = @twit.comments.create(comment_params)
    redirect_to twit_path(@twit)
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :body)
    end
end
