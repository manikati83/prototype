class Work < ApplicationRecord
  belongs_to :request
  belongs_to :worker, class_name: 'User'
  
  has_many :talks
  
  has_many :client_evaluations
  has_many :worker_evaluations

  def days
    today = Date.today
    deadline = (self.deadline - today).to_i
    if deadline < 0
      return -1
    end
    return deadline
  end
end
