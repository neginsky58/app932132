class ProductsController < ApplicationController

  def index
    puts 'DEBUG1:', ENV["FACEBOOK_ID"]
    puts 'DEBUG2:', ENV["FACEBOOK_SECRET"]

  end

end
