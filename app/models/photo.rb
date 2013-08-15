class Photo < ActiveRecord::Base
  PRICE = 1000

  belongs_to :user

  scoped_search :on => [:title, :description]

  mount_uploader :upload, UploadUploader

  has_many :comments, as: :commentable
end
