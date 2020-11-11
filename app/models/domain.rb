class Domain < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  def indexed?
    status == 'indexed'
  end
end
