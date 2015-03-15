class User < ActiveRecord::Base
    has_many :posts
    has_many :thrs

    validates :login, length: { in: 2..20,
                                message: "Login must have 2..20 characters!" }
    validates :login, uniqueness: true
    validates :email, email_format: { message: "Doesn't look like an email address, lol" }
    validates :password, length: { in: 6..20,
                                   message: "Password must have 6..20 characters!" }
end
