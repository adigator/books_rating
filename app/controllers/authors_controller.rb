class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)
    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Utworzono autora.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @author = Author.find(params[:id])
    @books = Book.where(:id => @author.book_id)
  end


def update
  respond_to do |format|
    if @author.update(author_params)
      format.html { redirect_to @author, notice: 'Autor poprawiony.' }
      format.json { render :show, status: :ok, location: @author }
    else
      format.html { render :edit }
      format.json { render json: @author.errors, status: :unprocessable_entity }
    end
  end
end


def destroy
  @author.destroy
  respond_to do |format|
    format.html { redirect_to authors_url, notice: 'Autor usuniety.' }
    format.json { head :no_content }
  end
end

private
def set_author
  @author = Author.find(params[:id])
end

def author_params
  params.require(:author).permit(:name, :surname, :country, :book, :image)
end
end
