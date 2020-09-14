class CommentsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', {content: @comment, nickname: @comment.user.nickname}
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
