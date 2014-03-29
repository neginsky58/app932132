
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except=>[:join]
  
  def friends
    @friends = current_user.friends.map{|f| f[:picture] = f['picture']['data']['url']; f}
  end

  def settings
    @favorite = Favorite.new
    @favorites = Favorite.all
  end

  def join    
    @circles = Circle.where(:status => true)
    render layout: 'join'
  end

  def join_circle
    
    respond_to do |format|
      circle_id = params[:circle_id]
      if circle_id.to_i > 0
        current_user.update_attribute(:circle_id, circle_id)      
      end  
      if current_user.circle_id > 0 
        format.html { redirect_to items_url }
      else
        format.html { redirect_to action: 'join' }
      end      
    end

  end

end
