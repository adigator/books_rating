class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :edit, :update, :destroy]

  def search
    if params[:search].present?
      @books = Book.search(params[:search])
    else
      @books = Book.all
    end
  end

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def edit
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    @authors = Author.all
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
    @reviews = Review.where(book_id: @book.id).order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end

  end

  def update

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Ksiazka poprawiona.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Ksiazka usunieta.' }
      format.json { head :no_content }
    end
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end
  def book_params
    params.require(:book).permit(:title, :year, :publisher, :genre, :description, :country, :image, :author_ids => [])
  end
end
