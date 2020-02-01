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
  @all_bookings_report = Booking.bookings_report()
  erb( :"bookings/index" )
end


# for when we create booking from classes view

get '/bookings/new' do

  erb( :"bookings/new" )
end



get '/bookings/:id/edit' do
  @members = Member.all
  @activities = Activity.all
  @classes = GymClass.all
  @booking_to_edit = Booking.find(params['id'].to_i)
  @current_class = GymClass.find(@booking_to_edit.gym_class_id)


  erb( :"bookings/edit" )
end





# a booking for a particular class(class to member booking)

get '/bookings/new/classes_to_members/:id' do
  @class = GymClass.find(params['id'].to_i)
  @members = Member.all
  @activity = Activity.find(@class.activity_id)
  erb( :"bookings/new_c_to_m" )
end

# post route specific to booking from class view (class to member booking)
post '/bookings/classes' do
  gym_member = Member.find(params['member_id'].to_i)
  @chosen_class = GymClass.find_by_activity_and_time(params)
  gym_member.book_a_class(@chosen_class)
  redirect to ('/classes')
end




# a booking for a particular member(member to class booking)
get '/bookings/new/members_to_classes/:id' do
  @activities = Activity.all()
  @classes = GymClass.all()
  @member = Member.find(params['id'].to_i)
  erb( :"bookings/new_c" )
end
# post route specifically for booking from members view
# and from classes view, maybe from bookings too.
post '/bookings/members' do
  gym_member = Member.find(params['member_id'].to_i)
  @chosen_class = GymClass.find_by_activity_and_time(params)
  gym_member.book_a_class(@chosen_class)
  redirect to ('/members')
end


# update after editing a booking - make sure values come back as appropriate!!!!!!!!!!!!!!!!!
post '/bookings/:id' do

# {"member_id"=>"3", "activity_id"=>" 5", "class_time"=> "10:00", "id"=>"6"}
#
#   hash = params.select {|k,v| k == 'activity_id' || k == 'class_time'}

  @new_gym_class = GymClass.find_by_activity_and_time(params)

  @booking_obj = Booking.find(params['id'].to_i)

  @booking_obj.gym_member_id = params['member_id'].to_i

  @booking_obj.gym_class_id = params[@new_gym_class.id]

  @booking_obj.update

  erb( :"bookings/updated" )
end
