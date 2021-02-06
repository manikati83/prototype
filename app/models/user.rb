class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :content, length: { maximum: 500 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :requests, foreign_key: 'client_id'
    
    has_many :applies, foreign_key: 'worker_id'
    has_many :applying, through: :applies, source: :request
    
    has_many :works, foreign_key: 'worker_id'
    
    def apply?(req)
      self.applying.include?(req)
    end
    
    def unapply(req)
      apply = self.applies.find_by(request_id: req.id)
      apply.destroy if apply
    end
end
