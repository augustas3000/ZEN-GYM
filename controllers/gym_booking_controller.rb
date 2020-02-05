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
  @classes = GymClass.all
  @members = Member.all
  @activities = Activity.all
  erb( :"bookings/new" )
end


post '/bookings' do

  @class = GymClass.find(params['class_id'].to_i)
  @member = Member.find(params['member_id'].to_i)
  @result = @member.book_a_class(@class)
  erb( :"bookings/created" )
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
  @result = gym_member.book_a_class(@chosen_class)

  # booking successful?
  erb( :"bookings/booked_from_class" )
end



# a booking for a particular member(member to class booking)
get '/bookings/new/members_to_classes/:id' do
  @activities = Activity.all()
  @classes = GymClass.all()
  @member = Member.find(params['id'].to_i)
  erb( :"bookings/new_c" )
end
# post route specifically for booking from members view

post '/bookings/members' do

  @gym_member = Member.find(params['member_id'].to_i)
  @chosen_class = GymClass.find(params['class_id'].to_i)
  @result = @gym_member.book_a_class(@chosen_class)
  erb( :"bookings/booked_from_member" )
end



post '/bookings/:id' do
  @booking_obj = Booking.find(params['id'].to_i)
  @new_member_obj = Member.find(params['member_id'].to_i)
  @new_gym_class = GymClass.find_by_activity_and_time(params)
  @old_gym_class = GymClass.find(@booking_obj.gym_class_id)
  @result = @booking_obj.edit_booking(@new_member_obj,@old_gym_class,@new_gym_class)
  # binding.pry
  erb( :"bookings/updated" )
end

post '/bookings/:id/delete' do
  @booking_to_delete = Booking.find(params['id'].to_i)
  @booking_to_delete.delete
  redirect '/bookings'
end
