class Story < ActiveRecord::Base
    
    acts_as_votable
    
    validates :title, :presence => true
    validates :description, :presence => true
    
    belongs_to :user
    has_one :category
    
    has_many :comments, dependent: :destroy
    
    
end
