class Item < ApplicationRecord
    include Concerns::Images::Imageable

    validates :title, :description, :cost, presence: true
    validates :title, uniqueness: true

    resourcify
end
