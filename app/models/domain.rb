class Domain < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  def indexed?
    !last_indexed_at.nil?
  end
end
