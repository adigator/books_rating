class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_book


  def new
    @review = Review.new
  end

  
  def edit
  end


  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.book_id = @book.id
    if @review.save
      redirect_to @book
    else
      render 'new'
    end
  end


  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @book, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:book_id])

    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
