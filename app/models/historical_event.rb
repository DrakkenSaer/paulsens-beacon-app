class HistoricalEvent < ApplicationRecord
    include Concerns::Images::ValidatesAttachment

    validates :title, :description, :date, presence: true, uniqueness: true

    resourcify
end