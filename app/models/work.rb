class Work < ApplicationRecord
  belongs_to :request
  belongs_to :worker, class_name: 'User'
  
  has_many :talks
  
  validates :deadline, presence: true
end
