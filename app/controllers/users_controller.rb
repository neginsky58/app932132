


class UsersController < ApplicationController

  def friends
    @friends = current_user.friends.map{|f| f[:picture] = f['picture']['data']['url']; f}
  end
  def settings
    
  end
end
