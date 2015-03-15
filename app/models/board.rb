class Board < ActiveRecord::Base
    has_many :thrs

    validates :name, length: { in: 1..20,
                               message: "Board name must have 1..20 characters!"}
    validates :pages_limit, numericality: { only_integer: true,
                                            greater_than: 0,
                                            message: "Pages limit must be greater than 0!"}
    validates :bumplimit, numericality: {  only_integer: true,
                                            greater_than: 0, 
                                            message: "Bumplimit limit must be greater than 0!"}                                         

end
