class Request < ApplicationRecord
  belongs_to :client, class_name: 'User'
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :apply_days, presence: true
  
  mount_uploader :image, ImageUploader
  
#  has_many :applies
  has_many :applies, dependent: :destroy
  has_many :applying, through: :applies, source: :worker
  
  has_many :works
  has_many :workings, through: :works, source: :worker
  
  def client?(user)
    if (self.client == user)
      true
    else
      false
    end
  end
  
  
  
end
