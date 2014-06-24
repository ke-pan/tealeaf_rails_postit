class CategoriesController < ApplicationController

  before_action :admin_test, except: :show
    
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
    @category = Category.find_by(:slug => params[:id])
    @posts = @category.posts
  end

  private

  def category_params
    params.require(:category).permit([:name])
  end


end
