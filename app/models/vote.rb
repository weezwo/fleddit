class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :value, presence: true, inclusion: { in:[-1, 1], message:"must be either 1 or -1." }
end
