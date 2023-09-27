class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.wish = Wish.find(params[:wish_id])
    @wish = @comment.wish
    authorize @comment
    if @comment.save
      redirect_to wish_path(@comment.wish)
    else
      render 'wishes/show', status: :unprocessable_entity
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @wish = Wish.find(params[:wish_id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.update(comment_params)
    redirect_to wish_path(@comment.wish)
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to wish_path(@comment.wish)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
