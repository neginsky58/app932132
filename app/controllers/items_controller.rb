class ItemsController < ApplicationController
  
  def index
    
    @friends_fb_IDs = current_user.friends.map{|f| f['id']}

    @friends_fb_IDs = ["100007787911484"]
    # @member_IDs = User.find(:all, :conditions=>{:invited_user_id => manager_id}).collect(&:id)    
    # @books = Book.where({:user_id => @member_IDs, :is_public => '1'})
    # Item.joins(:user).where({:users=>{:circle_id=>1, :facebook_id=>"100007787911484"}})
    # Item.joins(:user).where({:users=>{:circle_id=>1, :facebook_id=>["100007787911484"]}})
    @items = Item.joins(:user).where({ :users => {:circle_id=>current_user.circle_id, :facebook_id => @friends_fb_IDs}})
  end
  
  def new
    @item = Item.new
    @photo = Photo.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      if params[:thumb_photo_id_1].to_i >0        
        photo = Photo.find(params[:thumb_photo_id_1].to_i)
        photo.update_attribute(:item_id, @item.id)
      end
      if params[:thumb_photo_id_2].to_i >0        
        photo = Photo.find(params[:thumb_photo_id_2].to_i)
        photo.update_attribute(:item_id, @item.id)
      end
      if params[:thumb_photo_id_3].to_i >0        
        photo = Photo.find(params[:thumb_photo_id_3].to_i)
        photo.update_attribute(:item_id, @item.id)
      end
      if params[:thumb_photo_id_4].to_i >0        
        photo = Photo.find(params[:thumb_photo_id_4].to_i)
        photo.update_attribute(:item_id, @item.id)
      end

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

  def set_mine
    respond_to do |format|
      item_id = params[:item_id]
      item = Item.find(item_id)
      item.update_attributes({bid_user_id: current_user.id, updated_at: DateTime.now})
      format.json { render json: {success: true} }
    end
  end

  def set_mine
    respond_to do |format|
      item_id = params[:item_id]
      item = Item.find(item_id)
      item.update_attributes({bid_user_id: current_user.id, updated_at: DateTime.now})
      format.json { render json: {success: true} }
    end
  end

  def watchlist
    respond_to do |format|
      #@friends_fb_IDs = current_user.friends.map{|f| f['id']}
      @friends_fb_IDs = ["100007787911484"]

      @items = Item.joins(:user).where(['bid_user_id > 0']).where({:users => {:circle_id=>current_user.circle_id, :facebook_id => @friends_fb_IDs}})
      ary_items = @items.map {|f| 
        {id: f.id, name: f.name, price: f.price, user_name: f.user.name}
      }
      format.html { render :layout => false  }
      format.json { render json: {success: true, items: ary_items}}
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :price, :is_negotiable, :condition_id, :category_id, :person_type_id, :size_id, :link)
  end

end
