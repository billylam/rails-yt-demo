# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(username: "Guest", email: "foo@bar.com")
user.save(validate: false)
p1 = user.playlists.create(name: "Welcome to")
p2 = user.playlists.create(name: "A New Playlist")

#this skips controller create...  fix this to use create
Video.create(url_raw:"http://www.youtube.com/watch?v=5NV6Rdv1a3I")
Video.create(url_raw:"http://www.youtube.com/watch?v=6uBK5kvakD8")
Video.create(url_raw:"http://www.youtube.com/watch?v=h1LgaV-dyEs")
Video.create(url_raw:"https://www.youtube.com/watch?v=2zNSgSzhBfM")
Video.create(url_raw:"https://www.youtube.com/watch?v=1bk8s7JpKv0")
Video.create(url_raw:"http://www.youtube.com/watch?v=o1tj2zJ2Wvg")

p1.pl_additions.create(video_id: 1)
p1.pl_additions.create(video_id: 2)
p1.pl_additions.create(video_id: 4)
p1.pl_additions.create(video_id: 5)
p2.pl_additions.create(video_id: 2)
