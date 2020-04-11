class CommentsController < ApplicationController  
  prepend_before_action :set_commentable, only: %i(create destroy)
  before_action :set_comment, only: %i(destroy)  

  def create  
    @comment = @commentable.comments.build(comments_params)
    if @comment.save  
      flash[:success] = "コメントが投稿されました"  
      redirect_back(fallback_location: root_path)
    else
      render "new"
    end  
  end  

  def destroy  
    if @comment.destroy  
      flash[:success] = "コメントが削除されました"
      redirect_back(fallback_location: root_path)
    end  
  end  

  private  
    def set_comment  
      @comment = @commentable.comments.find(params[:id])  
    end  

    def comments_params  
      params.require(:comment).permit(:content, :user_id)  
    end  
end  