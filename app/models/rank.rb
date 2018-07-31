class Rank < ApplicationRecord
  belongs_to :ranker, :class_name => 'User', :inverse_of => :ranks
  belongs_to :rankee, :class_name => 'User'
end
