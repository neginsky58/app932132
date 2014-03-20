class CirclesController < ApplicationController

  def new
    @circle = Circle.new    
  end
  
  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def edit
    @circle = Circle.find(params[:id])
  end

  def index
    @circles = Circle.all
  end

  def update
    @circle = Circle.find(params[:id])
    if @circle.update_attributes(circle_params)
      redirect_to action: 'index'
    else
      redirect_to action: 'edit'
    end
  end
  def destroy
        
  end
  private
  def circle_params
    params.require(:circle).permit(:name, :zipcode, :city, :state, :status)
  end
end
