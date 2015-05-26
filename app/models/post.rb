class Post < ActiveRecord::Base.send(:include, Rails.application.routes.url_helpers)
    include ActionView::Helpers::UrlHelper

    belongs_to :thr
    belongs_to :user
    has_and_belongs_to_many :answers,
        class_name: "Post",
        foreign_key: "post_id",
        association_foreign_key: "answer_id",
        join_table: "answers_posts"
    has_and_belongs_to_many :parent_posts,
        class_name: "Post",
        foreign_key: "answer_id",
        association_foreign_key: "post_id",
        join_table: "answers_posts"

    has_attached_file :pic, styles: { medium: "700x700>", small: { geometry:'200x200', animated: false } }, :default_url => "/images/:style/missing.png"    
            
    validates :content, presence: true,
                        length: { maximum: 15000 }           

    validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/  
               
    validates :youtube_video, format: { with: /\A^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})\Z/i },
                              allow_blank: true 

    validate :only_one_media                          

    after_create :post_with_answers

    scope :op_post, -> { order(:created_at).first }

    def only_one_media
        if pic_file_size && !youtube_video.blank?
            errors.add(:youtube_video, "cannot be added with Image")
        end    
    end    

    def post_with_answers
        parent_posts_id = self.content.scan(/>>\d+/).join(' ').scan(/\d+/)
        parent_posts_id.each do |parent_post_id|           
            if parent_post = Post.find_by_id(parent_post_id)
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

    def post_number
        self.thr.posts.where("created_at < ?", self.created_at).count + 1
    end    

end
