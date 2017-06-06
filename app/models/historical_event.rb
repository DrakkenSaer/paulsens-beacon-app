class HistoricalEvent < ApplicationRecord
    include Concerns::Images::Imageable

    validates :title, :description, :date, presence: true, uniqueness: true

    resourcify
end