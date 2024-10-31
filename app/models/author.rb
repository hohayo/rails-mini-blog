class Author < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "email", "id", "name", "updated_at" ]
  end
end
