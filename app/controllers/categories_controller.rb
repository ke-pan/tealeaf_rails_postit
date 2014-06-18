class CategoriesController < ApplicationController

  before_action :login_test, except: :show
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    # binding.pry

    if @category.save
      flash[:notice] = "New category was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    # binding.pry
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  private

  def category_params
    params.require(:category).permit([:name])
  end

  def login_test
    unless logged_in?
      flash[:error] = "Please log in first."
      redirect_to root_path
    end
  end

end
