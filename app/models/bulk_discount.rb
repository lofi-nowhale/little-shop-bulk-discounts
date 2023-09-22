class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_numericality_of :percentage, :threshold
  validates_presence_of :name
end