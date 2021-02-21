class Apply < ApplicationRecord
  belongs_to :worker, class_name: 'User'
  belongs_to :request
  
  validates :content, presence: true, length: { maximum: 250 }
end
