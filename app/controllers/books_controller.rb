class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :edit, :update, :destroy]


  def ranking
      @hasz = {}
      @books = Book.all



      if params[:year].present?
        @books = @books.where(:year => params[:year])
      end

      if params[:country].present?
        @books = @books.where(:country => params[:country])
      end

      if params[:publisher].present?
        @books = @books.where(:publisher => params[:publisher])
      end

      if params[:genre].present?
        @books = @books.where(:genre => params[:genre])
      end

      @books.each do |book|
        @hasz[book] = book.get_average_rating.to_f
        book.get_average_rating
      end

      @ranked_sorted = {}

      @hasz.sort{|a,b| a[1]<=>b[1]}.each { |elem|
        @ranked_sorted[elem[0]] = elem[1]
        puts "#{elem[0]}, #{elem[1]}"
      }


  end

  def index
    @books = Book.page(params[:page]).per(12)
    if params[:title].present?
      @books = @books.where(:title => params[:title])
    end
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
        @book.author_ids.each do |a|
            @at = Author.find(a)
            asd = @at.book_ids
            asd.push @book_id
            @at.book_ids = asd
            puts asd
            @at.save
        end

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
    @rat = false
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
    if current_user
      @reviews.each do |rev|
        if rev.user_id == current_user.id
          @rat = true
        end
      end
    end
    if @rat
    puts "jest rat"
    else
      puts "nie ma"
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
