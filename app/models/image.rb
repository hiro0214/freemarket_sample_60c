class Image < ApplicationRecord

  belongs_to :item
  mount_uploader :url, ImageUploader

end
