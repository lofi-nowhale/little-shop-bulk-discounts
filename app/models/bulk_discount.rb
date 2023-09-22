class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_numericality_of :percentage, :threshold
end