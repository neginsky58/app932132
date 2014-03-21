class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end
  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite[:user_id] = current_user.id
    if @favorite.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def destroy
    @favorite = Favorite(params[:id])
    if @favorite.user_id == current_user.id
      @favorite.destroy
    else
      flash[:danger] = 'Not allowered to delete the favorite'
    end
  end

  private
  def favorite_params
    params.require(:favorite).permit(:category_id, :person_type_id, :size_id, :search_word)
  end
end
