class ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item[:user_id] = current_user.id
    if @item.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end    
  end

  def edit
    @item = Item.find(params[:id])    
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attribute(item_params) 
      redirect_to action: 'index'
    else
      redirect_to action: 'edit'
    end
  end

  def destroy    
    @item = Item.find(params[:id])
    if @item 
      @item.destroy
    end
    redirect_to action: 'index'    
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :price, :is_negotiable, :condition_id, :category_id, :person_type_id, :size_id, :link)
  end

end
