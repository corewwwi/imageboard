class Board < ActiveRecord::Base
    has_many :thrs, dependent: :destroy

    validates :name, presence: true,
                     uniqueness: true,
                     length: { maximum: 5 }
    validates :pages_limit, numericality: { only_integer: true,
                                            greater_than: 0 }
    validates :bumplimit, numericality: { only_integer: true,
                                          greater_than: 0 }
    validates :description, length: { maximum: 30 }
     
    validates :terms, length: { maximum: 100 }

    def to_param
      name
    end

end