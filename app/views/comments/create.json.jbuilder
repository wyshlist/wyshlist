if @comment.persisted?
  json.form render(partial: "comments/form", formats: :html, locals: {comment: Comment.new, wish: @wish})
  json.inserted_item render(partial: "comments/comment", formats: :html, locals: {comment: @comment, wish: @wish, comments: @wish.comments})
else
  json.form render(partial: "comments/form", formats: :html, locals: {comment: @comment, wish: @wish})
end
