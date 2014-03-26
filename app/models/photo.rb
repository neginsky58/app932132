class Photo < ActiveRecord::Base
  

  has_attached_file :file, 
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :styles => { :medium => "1024x768>", :thumb => "100x100>" }, 
    :default_url => "no_image.jpg"

  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  # attr_accessor :file_file_name
  attr_accessor :file_content_type
  attr_accessor :file_file_size
  attr_accessor :file_updated_at 

end

