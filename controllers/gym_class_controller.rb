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


# Show a list of gym members:
get '/classes' do
  # get array of member objects from database
  @activities = Activity.all
  @classes = GymClass.all
  erb( :"classes/index" )
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
