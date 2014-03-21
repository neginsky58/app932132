


class UsersController < ApplicationController

  def friends
    @friends = current_user.friends.map{|f| f[:picture] = f['picture']['data']['url']; f}
  end
  def settings
    @favorite = Favorite.new
    @favorites = Favorite.all
  end

end
