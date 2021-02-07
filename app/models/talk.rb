class Talk < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :content, presence: true, length: { maximum: 255 }
end
