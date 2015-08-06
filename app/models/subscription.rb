class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :thr

  validates_uniqueness_of :user_id, scope: :thr_id

end
