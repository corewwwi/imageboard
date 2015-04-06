class Post < ActiveRecord::Base.send(:include, Rails.application.routes.url_helpers)
    include ActionView::Helpers::UrlHelper
    belongs_to :thr
    belongs_to :user
    has_and_belongs_to_many :answers,
        :class_name => "Post",
        :association_foreign_key => "answer_id",
        :join_table => "answers_posts"
    has_attached_file :pic, :styles => { :medium => "700x700>", :small => "200x200>" }, :default_url => "/images/:style/missing.png"    

    validates :content, length: { in: 1..15000, 
                                  message: "Content must have 1..15000 characters!"}  
     
      
    validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/  

    #validates_format_of :youtube_video, :with => /\A^http:\/\/(?:www\.)?youtube.com\/watch\?(?=[^?]*v=\w+)(?:[^\s?]+)?$\Z/i,
                 #:message => "your message", :on => :create 
    after_create :post_with_answers

    scope :simple_posts, -> { where(op: false) }
    scope :op_post, -> { where(op: true) } 	  


    def post_with_answers
        parent_posts_id = self.content.scan(/>>\d+/).join(' ').scan(/\d+/)
        parent_posts_id.each do |parent_post_id|          
            if parent_post = self.thr.posts.find_by_id(parent_post_id)
                parent_post.answers << self unless parent_post.answers.include?(self)
            end
        end
        
    end    

    def youtube_embed
        if self.youtube_video[/youtu\.be\/([^\?]*)/]
            youtube_id = $1
        else
            self.youtube_video[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
            youtube_id = $5
        end
        %Q{ <iframe class="embed-responsive-item" frameborder="0" width="560" height="315" src="//www.youtube.com/embed/#{ youtube_id }" allowfullscreen=""></iframe> }
    end                                                    
end
