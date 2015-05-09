class Video < ActiveRecord::Base
  mount_uploader :source, VideoUploader
  acts_as_taggable
  acts_as_commentable
  paginates_per 12
  belongs_to :user
end
