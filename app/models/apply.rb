class Apply < ApplicationRecord
  belongs_to :worker, class_name: 'User'
  belongs_to :request, class_name: 'Request'
  
  validates :content, presence: true, length: { maximum: 255 }
end
