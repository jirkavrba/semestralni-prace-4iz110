class Domain < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  has_many :indexed_pages

  def indexed?
    status == 'indexed'
  end
end
