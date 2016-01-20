# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Book.create(:title => "ksiazka o id 1", :year => "2211", :publisher => "publisher", :genre => "horror", :cober => "asd.jpg", :description => "adas das dasd as das ksiazka o id 1",:rating => 0, :rates => 0, :country => "rosja", :author_id => 2)
Author.create(:name => "adi", :surname => "gator", :rating => 0, :rates => 0, :country => 'russia', :book_id => 1)
Book.create(:title => "ksiazka o id 2", :year => "2221", :publisher => "publisher2", :genre => "komedia", :cober => "asd2.jpg", :description => "adas das dasd as das ksiazka o id 1",:rating => 0, :rates => 0, :country => "rosja", :author_id => 1)
Author.create(:name => "adiaa", :surname => "wwgator", :rating => 0, :rates => 0, :country => 'russia', :book_id => 2)