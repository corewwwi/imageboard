class Post < ActiveRecord::Base
	belongs_to :thr
	belongs_to :user

	validates :content, length: { in: 1..500, 
		                          message: "Content must have 1..500 characters!"}
end
