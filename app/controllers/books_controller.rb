class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  def new
    @book = Book.new
  end
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Utworzono książkę.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
    @book = Book.find(params[:id])
    @authors = Author.where(:id => @book.author_id)
  end
  private
  def book_params
    params.require(:book).permit(:title, :year, :publisher, :genre, :cober, :description, :country, :author, :image)
  end
end
