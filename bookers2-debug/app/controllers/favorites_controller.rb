class FavoritesController < ApplicationController
    
    before_action :set_book
    
    def create
      @book = Book.find(params[:book_id])
      @favorite = Favorite.new(user_id: current_user.id, book_id:  @book.id)
      @favorite.save
    end
    
    def destroy
      @book = Book.find(params[:book_id])
      @favorite = Favorite.find_by(user_id: current_user.id, book_id:  @book.id)
      @favorite.destroy
    end
    
    private
    
    def set_book
      @book = Book.find_by(params[:book_id])
    end
end
