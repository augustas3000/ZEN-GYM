require 'pry'
require 'pry-byebug'
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/gym_booking.rb' )
require_relative( '../models/gym_activity.rb' )
require_relative( '../models/gym_class.rb' )
require_relative( '../models/gym_member.rb' )

also_reload( '../models/*' )


get '/activities' do
  @all_activities = Activity.all

  erb( :"activities/index" )
end


get '/activities/new' do

  erb( :"activities/new" )
end


post '/activities' do
  # params = {"activity_name"=>"basketball"}
  @new_activity = Activity.new(params)
  @result = @new_activity.save 
  erb( :"activities/created" )
end

# /photos/:id/edit	GET	edit
get '/activities/:id/edit' do
  @activity_current = Activity.find(params['id'].to_i)
  @activities_all = Activity.all
  erb( :"activities/edit" )
end

post '/activities/:id' do
  @activity_current = Activity.find(params['id'].to_i)
  @result = @activity_current.change_name(params['activity_name'])
  erb( :"activities/updated" )
end
