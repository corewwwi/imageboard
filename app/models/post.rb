class Post < ActiveRecord::Base
    belongs_to :thr
    belongs_to :user
    has_and_belongs_to_many :answers,
        :class_name => "Post",
        :association_foreign_key => "answer_id",
        :join_table => "answers_posts"

    validates :content, length: { in: 1..500, 
                                  message: "Content must have 1..1000 characters!"}   
      
    has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/                              

    scope :simple_posts, -> { where(op: false) }
    scope :op_post, -> { where(op: true) } 	                                                      
end
