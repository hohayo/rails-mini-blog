class Author < ApplicationRecord
  has_many :posts, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :square, resize_to_fill: [ 250, 250 ]
    attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
    attachable.variant :medium, resize_to_fill: [ 300, 300 ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "email", "id", "name", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "posts" ]
  end
end
