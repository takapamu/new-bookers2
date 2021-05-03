class BookCommentsController < ApplicationController
    
 def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(comment_params)
    @comment.book_id = book.id
    @comment.save
    redirect_to book_path(book)
 end
 
 def destroy
    @book = Book.find(params[:book_id])
    comment = @book.book_comments.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
     
 end
 
   private

  def comment_params
    params.require(:book_comment).permit(:comment)
  end

 
end
