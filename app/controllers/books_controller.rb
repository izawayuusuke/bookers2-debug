class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :set_book, only: [:edit, :update]

	def show
		@new_book = Book.new
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
  end

	def index
		@book = Book.new
		@books = Book.all
  end

  def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
		else
			@user = current_user
			@books = Book.all
			render 'index'
		end
  end

  def edit
		@book = Book.find(params[:id])
  end



  def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to @book, notice: "successfully updated book!"
		else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
			render "edit"
		end
  end

  def destroy
		@book = Book.find(params[:id])
		@book.destoy
		redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
		params.require(:book).permit(:title, :body)
	end

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def set_book
		@book = Book.find(params[:id])
		unless @book.user == current_user
			redirect_to books_path
		end
	end
end
