class BooksController < ApplicationController
  def index
    @books = Book.all
    if request.get == nil
      puts "asd"
    end
  end
  def show
    @book = Book.find(params[:id])
    @authors = Author.where(:id => @book.author_id)
  end
end
