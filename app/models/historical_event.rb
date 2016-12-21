class HistoricalEvent < ApplicationRecord
    validates :title, :description, :date, presence: true, uniqueness: true

    resourcify
end