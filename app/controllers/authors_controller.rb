class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end
  def show
    @author = Author.find(params[:id])
    @books = Book.where(:id => @author.book_id)
  end
end
