class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @favorites = current_user.favorites
  end

  def new
    @favorite = Favorite.new
    respond_to do |format|
      format.html 
      format.json { render json: @favorite }
    end
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite[:user_id] = current_user.id
    respond_to do |format|
      if @favorite.save
        format.html { render action: 'index' }
        format.json { render json: {id: @favorite.id, category: @favorite.category.name, person_type: @favorite.person_type.name, size: @favorite.size.name, search_word: @favorite.search_word} }
      else
        format.html { render action: 'new' }
        format.json { render json: { :error => @favorite.errors} }
      end
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
  
  def delete_selected
    ary_ids = []
    ids = params[:favorite]
    ids.each do |key, value|
      ary_ids << key
      id = key[3..-1].to_i
      Favorite.destroy(id)      
    end
    respond_to do |format|
      format.html
      format.json { render json: ary_ids }
    end

  end

  private
  def favorite_params
    params.require(:favorite).permit(:category_id, :person_type_id, :size_id, :search_word)
  end
end
