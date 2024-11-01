class Post < ApplicationRecord
  belongs_to :author

  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    [ "author_id", "body", "created_at", "id", "published_at", "title", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "author" ]
  end
end
