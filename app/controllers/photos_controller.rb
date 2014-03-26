class PhotosController < ApplicationController
  # before_filter :default_format_js, only: :create

  # def default_format_js
  #     reponse.headers['content--type'] = 'text/javascript'
  #     request.format = 'js'
  # end
  
  def new
    @photo = Photo.new
  end

  def create

    @photo = Photo.create(photo_params)
    respond_to do |format|
      if @photo
        puts '====URL:=====', @photo.file.url
        #format.html { redirect_to action: 'index'}
        format.json { render json: {success: true, url: @photo.file.url, photo_id: @photo.id } }
      else
        #format.html { redirect_to action: 'new' }
        format.json { render json: {success: false } }
      end
      # format.json { render json: {success: true, url: 'http://enprojo.s3.amazonaws.com/photos/files/000/000/004/original/94a0c452dad381f6c5ee0003815cff78.jpeg?1395812829', photo_id: '4' } }
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
    params.require(:photo).permit(:file, :file_file_name)
  end
end
