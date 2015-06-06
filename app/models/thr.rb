class Thr < ActiveRecord::Base

  belongs_to :board
  belongs_to :user
  has_many :posts, dependent: :destroy

  accepts_nested_attributes_for :posts
 
  validates :title, presence: true,
            length: { maximum: 70 }
  
  before_destroy :delete_pic

  # for saving thr without nested attributes
  # def save_with_post(post)
  #     Thr.transaction do
  #         save!
  #         post.thr = self
  #         post.save!
  #     end
  # rescue => e
  #     false
  # end

  def delete_pic
    self.posts.each do |post|
      post.pic.destroy
    end
  end

  def bump_limit?
    self.posts.count >= self.board.bumplimit ? true : false
  end

end