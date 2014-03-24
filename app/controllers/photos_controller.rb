class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create

    @photo = Photo.new(photo_params)
    respond_to do |format|
      if @photo.save
        format.html 
        format.json { render json: {success: true, url: @photo.file.url } }
      else
        format.html 
        format.json { render json: {success: false } }
      end
    end    
  end
  
  def index
    @photos = Photo.all
  end


  def edit

  end

  def update

  end

  private
  def photo_params
    params.require(:photo).permit(:file)
  end
end
