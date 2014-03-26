module ItemsHelper
  
  def get_thumbnails(item)
    thumbnails = Photo.find(:all, :conditions=>{:item_id =>item.id})
    ary_thumbnails = []
    thumbnails.each do |thumbnail| 
      ary_thumbnails << thumbnail.file.url
    end
    ary_thumbnails
  end

end
