class Solution < ActiveRecord::Base
  attr_accessible :answer, :question_id
  
  belongs_to :question
end
