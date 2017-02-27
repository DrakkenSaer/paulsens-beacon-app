class Currency < ApplicationRecord
  include Concerns::Polymorphic::Helpers

  belongs_to :cashable, polymorphic: true
end
