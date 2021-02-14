class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :content, length: { maximum: 500 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    mount_uploader :image, ImageUploader
    
    has_many :requests, foreign_key: 'client_id'
    
    has_many :applies, foreign_key: 'worker_id'
    has_many :applying, through: :applies, source: :request
    
    has_many :works, foreign_key: 'worker_id'
    has_many :workings, through: :works, source: :request
    
    has_many :talks
    
    has_many :client_evaluations
    has_many :worker_evaluations
    
    def apply?(req)
      self.applying.include?(req)
    end
    
    def unapply(req)
      apply = self.applies.find_by(request_id: req.id)
      apply.destroy if apply
    end
    
    def client_ave
      count = self.client_evaluations.count
      s = 0.0
      self.client_evaluations.each do |eva|
        s += eva.evaluation.to_i
        puts s
      result = s / count
      return result
      end
    end
    
    def worker_ave
      count = self.worker_evaluations.count
      sum = 0
      self.worker_evaluations.each do |eva|
        sum += eva.evaluation.to_i
      result = sum / count
      return result
      end
    end
  
end
