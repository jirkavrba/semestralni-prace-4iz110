class Domain < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
