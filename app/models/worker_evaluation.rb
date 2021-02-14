class WorkerEvaluation < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :evaluation, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  validates :user, presence: true
  validates :work, presence: true
  validates :content, presence: true
  
end
