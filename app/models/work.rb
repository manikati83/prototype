class Work < ApplicationRecord
  belongs_to :request
  belongs_to :worker
end
