class Rank < ApplicationRecord
  belongs_to :ranker, :class_name => 'User', :foreign_key => :ranker_id, :inverse_of => :ranks
  belongs_to :rankee, :class_name => 'User'
end
