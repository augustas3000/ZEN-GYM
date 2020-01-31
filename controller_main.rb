require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('controllers/gym_activity_controller')
require_relative('controllers/gym_booking_controller')
require_relative('controllers/gym_class_controller')
require_relative('controllers/gym_member_controller')


get '/' do
  erb( :"home/home" )
end
