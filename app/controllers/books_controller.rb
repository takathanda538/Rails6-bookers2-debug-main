class BooksController < ApplicationController

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @see = See.find_by(ip: request.remote_ip)
    if @see
      @books = Book.all
    else
      @books = Book.all
      See.create(ip: request.remote_ip)
    end
  end

  def index
    @book = Book.new
    @books = Book.includes(:favorite_users).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
    @today_book = Book.created_today
    @today_book_1 = Book.created_yesterday
    @today_book_2 = Book.created_yesterday_2
    @today_book_3 = Book.created_yesterday_3
    @today_book_4 = Book.created_yesterday_4
    @today_book_5 = Book.created_yesterday_5
    @today_book_6 = Book.created_yesterday_6
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
