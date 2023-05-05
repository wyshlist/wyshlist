class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.wish = Wish.find(params[:wish_id])
        @iwsh = @comment.wish
        if @comment.save
            redirect_to wish_path(@comment.wish)
        else
            render 'wishes/show', status: :unprocessable_entity
        end
    end

    def edit
        @comment = Comment.find(params[:id])
        @wish = Wish.find(params[:wish_id])
    end

    def update
        @comment = Comment.find(params[:id])
        @comment.update(comment_params)
        redirect_to wish_path(@comment.wish)
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to wish_path(@comment.wish)
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
