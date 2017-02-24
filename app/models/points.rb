class Points < ApplicationRecord
  include Concerns::Polymorphic::Helpers

  after_initialize :set_default_value

  belongs_to :pointable, polymorphic: true

  validates :value, presence: true

  protected

    def set_default_value
      self.value = 0 if self.value.nil?
    end

end
