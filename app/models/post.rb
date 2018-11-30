class Post < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  belongs_to :user, foreign_key: 'author_id'

  validates :title, presence: true
  validates :body, presence: true

    # sum up votes for each post and order by that sum
  scope :ordered_by_votes, -> { joins(:votes).group('posts.id').order('SUM("votes.value")') } # DANGEROUS!! CHANGE THIS!
end
