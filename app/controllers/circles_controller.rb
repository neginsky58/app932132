class CirclesController < ApplicationController
  layout 'admin'
  def new
    @circle = Circle.new    
  end
  
  def create
    @circle = Circle.new(circle_params)
    respond_to do |format|
      if @circle.save
        format.html { redirect_to action: 'index' }
        format.json { render json: {circle: @circle}}
      else
        format.html { redirect_to action: 'new' }
        format.json { render json: {success: false } }
      end
    end
  end

  def edit
    @circle = Circle.find(params[:id])  
    respond_to do |format|
      format.html
      format.json { render json: { circle: @circle } }
    end
  end

  def index
    @circles = Circle.all    
  end

  def update

    @circle = Circle.find(params[:id])    
    respond_to do |format|
      if @circle.update_attributes(circle_params)
        format.html { redirect_to action: 'index' }
        format.json { render json: {circle: @circle, success: true } }
      else
        format.html { redirect_to action: 'edit' }
        format.json { render json: { success: false } }
      end
    end

  end

  def delete_selected
    ary_ids = []
    ids = params[:circle]
    ids.each do |key, value|
      ary_ids << key
      id = key[3..-1].to_i
      Circle.destroy(id)      
    end
    respond_to do |format|
      format.html
      format.json { render json: ary_ids }
    end

  end

  def destroy
        
  end

  private
  def circle_params
    params.require(:circle).permit(:name, :zipcode, :city, :state, :status)
  end
end
