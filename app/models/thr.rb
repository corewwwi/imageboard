class Thr < ActiveRecord::Base
    belongs_to :board
    belongs_to :user
    has_many :posts
 
    validates :title, length: { in: 1..30,
                                message: "Title must have 1..30 characters!" }
                              
end
