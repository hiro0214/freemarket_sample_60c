class Image < ApplicationRecord

  belongs_to :item
  mount_uploader :url, ImageUploader

  validates :url, presence: true

end
