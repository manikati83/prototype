class Work < ApplicationRecord
  belongs_to :request
  belongs_to :worker, class_name: 'User'
  
  has_many :talks
  
  has_many :client_evaluations
  has_many :worker_evaluations
  
  validates :deadline, presence: true
end
