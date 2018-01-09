class Photo < ActiveRecord::Base
  include ImageUploader::Attachment.new(:image)

  has_many :photo_transformations
end
