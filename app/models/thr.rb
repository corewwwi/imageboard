class Thr < ActiveRecord::Base
    belongs_to :board
    belongs_to :user
    has_many :posts, dependent: :destroy 
 
    validates :title, length: { in: 1..30,
                                message: "Title must have 1..30 characters!" }
    
    #before_create :set_op 

    paginates_per 5

    def posts_count
    	self.posts.count - 1
    end	

    def thr_save(t, p)
    	transaction do
    		t.save
    		p.save
    	end
    end                   
end
