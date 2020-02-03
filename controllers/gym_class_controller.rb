require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/gym_class.rb' )
also_reload( '../models/*' )

# URL	HTTP Verb	Action
# /photos/	GET	index
# /photos/new	GET	new
# /photos	POST	create
# /photos/:id	GET	show
# /photos/:id/edit	GET	edit
# /photos/:id	PATCH/PUT	update
# /photos/:id	DELETE	destroy


# Show a list of gym classes:
get '/classes' do
  # get array of member objects from database
  @activities_hash = Activity.all.map { |activity| [activity.id.to_i, activity.activity_name] }.to_h


  @classes = GymClass.all
  erb( :"classes/index" )

end

get '/classes/new' do
  @activities = Activity.all

  # activity
  # class time
  # class_capacity
  # activation status


  erb( :"classes/new" )
end

post '/classes' do
  @new_gym_class = GymClass.new(params)
  @new_gym_class.save
  erb( :"classes/created" )
end

get '/classes/:id' do

  @activities = Activity.all
  @class = GymClass.find(params['id'].to_i)
  @current_activity = Activity.find(@class.activity_id)
  erb( :"classes/show" )
end








# provide a form for creating new members
# get '/classes/new' do
#   erb( :"classes/new" )
# end
#
# # use resulting form data to create a nobject and save it to db
# post '/classes' do
#   @new_member_obj = Member.new(params)
#   @new_member_obj.save
#   erb( :"classes/member_created" )
# end
#
# # show info of a particular member
# get '/classes/:id' do
#   @member = Member.find(params['id'].to_i)
#   erb( :"classes/show" )
# end
