# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	b = Board.create(name: "b", description: "Бред", terms: "Правила отсутствуют")
	pr = Board.create(name: "pr", description: "Программирование", terms: "Правила отсутствуют")
	mu = Board.create(name: "mu", description: "Музыка", terms: "Правила отсутствуют")

	thr1 = Thr.create(user_id: 1, title: "Это первый тред", board_id: 1 )
	thr2 = Thr.create(user_id: 1, title: "Это второй тред", board_id: 1 )
	thr3 = Thr.create(user_id: 1, title: "Это третий тред", board_id: 1 )
	thr4 = Thr.create(user_id: 1, title: "Это четверый тред", board_id: 1 )

	user1 = User.create(login: "абу", email: "123456@gmail.com", password: "1234")	
	user2 = User.create(login: "йоба", email: "12345@gmail.com", password: "1234")	
	user3 = User.create(login: "кек", email: "1234@gmail.com", password: "1234")	


	post1 = Post.create(user_id: 1, thr_id: 1, op: true, created_at: Time.now, content: "ОП-пост" )
	post2 = Post.create(user_id: 2, thr_id: 1, op: false, created_at: Time.now, content: "Ответ1" )
	post3 = Post.create(user_id: 3, thr_id: 1, op: false, created_at: Time.now, content: "Ответ2" )

	post4 = Post.create(user_id: 1, thr_id: 2, op: true, created_at: Time.now, content: "OP" )
	post5 = Post.create(user_id: 2, thr_id: 2, op: false, created_at: Time.now, content: "Crystal Castles were an experimental electronic band which formed in 2003 in Toronto, Ontario, Canada and consists of producer Ethan Kath and vocalist Alice Glass. They are named after the lyrics “The fate of the world is safe in Crystal Castles” and “Crystal Castles, the source of all power” both from the theme song for She-Ra’s fortress. They are known for their melancholic lo-fi sound and their explosive live shows. Their debut album was included in NME’s “Top 50 Albums of the Decade”." )
	post6 = Post.create(user_id: 3, thr_id: 2, op: false, created_at: Time.now, content: "Crystal Castles were an experimental electronic band which formed in 2003 in Toronto, Ontario, Canada and consists of producer Ethan Kath and vocalist Alice Glass. They are named after the lyrics “The fate of the world is safe in Crystal Castles” and “Crystal Castles, the source of all power” both from the theme song for She-Ra’s fortress. They are known for their melancholic lo-fi sound and their explosive live shows. Their debut album was included in NME’s “Top 50 Albums of the Decade”." )

	post7 = Post.create(user_id: 1, thr_id: 3, op: true, created_at: Time.now, content: "ОП-пост." )
	post8 = Post.create(user_id: 2, thr_id: 3, op: false, created_at: Time.now, content: "Ответ1" )
	post9 = Post.create(user_id: 3, thr_id: 3, op: false, created_at: Time.now, content: "Ответ2" )

	post10 = Post.create(user_id: 1, thr_id: 4, op: true, created_at: Time.now, content: "Длинный ОП-пост. Crystal Castles were an experimental electronic band which formed in 2003 in Toronto, Ontario, Canada and consists of producer Ethan Kath and vocalist Alice Glass." )
	post11 = Post.create(user_id: 2, thr_id: 4, op: false, created_at: Time.now, content: "Crystal Castles were an experimental electronic band which formed in 2003 in Toronto, Ontario, Canada and consists of producer Ethan Kath and vocalist Alice Glass. They are named after the lyrics “The fate of the world is safe in Crystal Castles” and “Crystal Castles, the source of all power” both from the theme song for She-Ra’s fortress. They are known for their melancholic lo-fi sound and their explosive live shows. Their debut album was included in NME’s “Top 50 Albums of the Decade”." )
	post12 = Post.create(user_id: 3, thr_id: 4, op: false, created_at: Time.now, content: "Crystal Castles were an experimental electronic band which formed in 2003 in Toronto, Ontario, Canada and consists of producer Ethan Kath and vocalist Alice Glass. They are named after the lyrics “The fate of the world is safe in Crystal Castles” and “Crystal Castles, the source of all power” both from the theme song for She-Ra’s fortress. They are known for their melancholic lo-fi sound and their explosive live shows. Their debut album was included in NME’s “Top 50 Albums of the Decade”." )

	