class Thr < ActiveRecord::Base
    belongs_to :board
    belongs_to :user
    has_many :posts, dependent: :destroy 
 
    validates :title, length: { in: 1..70,
                                message: "Title must have 1..70 characters!" }
    
    #before_create :set_op 

    before_destroy :delete_pic

    paginates_per 3

    def child_posts_count
    	self.posts.count - 1
    end	

    def save_with_post(post)
        Thr.transaction do
            save!
            post.thr = self
            post.save!
        end  
    end

    def delete_pic
        self.posts.each do |post| 
            post.pic.destroy
        end     
    end    

    def bump_limit?
        if self.posts.count >= self.board.bumplimit
            true
        end
    end    

           
end
