class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :username, :presence => true, :uniqueness => true
  validates :gender, :presence => true
  
  GENDER_TYPES = ["Masculino", "Femenino"]
  
  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  
end
