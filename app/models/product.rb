class Product < ApplicationRecord
    has_many :promotions, as: :promotional
end
