class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.wish = Wish.find(params[:wish_id])
        if @comment.save
            redirect_to wish_path(@comment.wish)
        else
            render 'wishes/show', status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
