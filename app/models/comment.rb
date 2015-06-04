class Comment < ActiveRecord::Base
    
    validates :comment, :presence => true
    
    belongs_to :story
    belongs_to :user
end
