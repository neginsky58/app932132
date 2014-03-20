class ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end    
  end

  def edit
  end
  
  def update
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :price, :is_negotiable, :condition_id, :category_id, :person_type_id, :size_id, :link)
  end

end
