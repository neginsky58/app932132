#Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:url] = 'http://s3.amazonaws.com/BidBuds'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'