# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    user = User.create(email: "user@gmail.com", password: "123456", username: "user", status: "user")  
    admin = User.create(email: "admin@gmail.com", password: "123456", username: "admin", status: "admin")    
    banned_user = User.create(email: "ban@gmail.com", password: "123456", username: "banned", status: "banned")    

    diy = Board.create(name: 'diy', description: 'Hobby', terms: 'Hobby and DIY')
    mov = Board.create(name: 'mov', description: 'Movies', terms: 'Movies and series')
    mu = Board.create(name: 'mu', description: 'Music', terms: 'All about music')
    pr = Board.create(name: 'pr', description: 'Programming', terms: 'Program on HTML')
    bo = Board.create(name: 'bo', description: 'Books', terms: 'Only books')


    
    4.times do |t|
        thr = Thr.create(title: "Thread #{t*3 + 1}", board_id: 1, user_id: 1)
        5.times do |p|
            pp = Post.create(thr_id: t*3 + 1, content: "Post #{p*2 + 1}", user_id: 1 )
            pp = Post.create(thr_id: t*3 + 1, content: "Post #{p*2 + 2}", user_id: 2 )  
        end
        
        thr = Thr.create(title: "Thread #{t*3 + 2}", board_id: 1, user_id: 2)
        100.times do |p|
            pp = Post.create(thr_id: t*3 + 2, content: "Post #{p*5 + 1}", user_id: 1 )
            pp = Post.create(thr_id: t*3 + 2, content: "Post #{p*5 + 2}", sage: true , user_id: 2 )
            pp = Post.create(thr_id: t*3 + 2, content: "Post #{p*5 + 3}", user_id: 1 )
            pp = Post.create(thr_id: t*3 + 2, content: "Post #{p*5 + 4}", user_id: 2 )
            pp = Post.create(thr_id: t*3 + 2, content: "Post #{p*5 + 5}", anon: true , user_id: 1 )
        end 

        thr = Thr.create(title: "Thread #{t*3 + 3}", board_id: 1, user_id: 1)
        50.times do |p|
            pp = Post.create(thr_id: t*3 + 3, content: "Post #{p + 1}", user_id: 1 )
        end
    end
    
    
   