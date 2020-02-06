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
  erb( :"classes/new" )
end

get'/classes/deactivated' do
  @activities_hash = Activity.all.map { |activity| [activity.id.to_i, activity.activity_name] }.to_h
  @classes = GymClass.all
  erb( :"classes/index_deactivated" )
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



get '/classes/:id/edit' do
  @current_class = GymClass.find(params['id'].to_i)
  @current_activity = Activity.find(@current_class.activity_id)

  @activities = Activity.all
  # link to form for editing
  erb( :"classes/edit" )
end

# updating
post '/classes/:id' do
  @class = GymClass.find(params['id'].to_i)
  @class.activity_id = params['activity_id'].to_i
  @class.class_time = params['class_time']
  @class.class_capacity = params['class_capacity'].to_i
  @class.class_activation_status = params['class_activation_status']
  @class.update

  erb( :"classes/updated" )
end

# deletion:
post '/classes/:id/delete' do
  @class_to_delete = GymClass.find(params['id'].to_i)
  @class_to_delete.delete
  erb( :"classes/deleted" )
end

post '/classes/:id/activate' do
  @class = GymClass.find(params['id'].to_i)
  @class.class_activation_status = 'active'
  @class.update
  redirect '/members'
end
