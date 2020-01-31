require 'pry'
require 'pry-byebug'
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/gym_booking.rb' )
require_relative( '../models/gym_activity.rb' )
require_relative( '../models/gym_class.rb' )
require_relative( '../models/gym_member.rb' )

also_reload( '../models/*' )


# URL	HTTP Verb	Action
# /photos/	GET	index
# /photos/new	GET	new
# /photos	POST	create
# /photos/:id	GET	show
# /photos/:id/edit	GET	edit
# /photos/:id	PATCH/PUT	update
# /photos/:id	DELETE	destroy

get '/bookings' do
  @all_bookings = Booking.all()
  erb( :"bookings/index" )
end


# for when we create booking from classes view

get '/bookings/new' do

  erb( :"bookings/new" )
end

# a booking for a particular member
get '/bookings/new/:id' do
  @activities = Activity.all()
  @classes = GymClass.all()
  @member = Member.find(params['id'].to_i)
  erb( :"bookings/new_c" )
end
#
post '/bookings' do

  gym_member = Member.find(params['member_id'].to_i)
  params.delete('member_id')
  @chosen_class = GymClass.find_by_activity_and_time(params)
  gym_member.book_a_class(@chosen_class)
  redirect to ('/members')
end
