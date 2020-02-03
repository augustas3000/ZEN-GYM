require( 'sinatra' )
require( 'sinatra/contrib/all' )
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


# Show a list of gym members:
get '/members' do
  # get array of member objects from database
  @members = Member.all
  erb( :"members/index" )
end

get '/members/deactivated' do
  @members_deactivated = Member.deactivated_members()
  erb( :"members/index_deactivated" )
end

# provide a form for creating new members
get '/members/new' do
  erb( :"members/new" )
end

# use resulting form data to create a nobject and save it to db
post '/members' do
  @new_member_obj = Member.new(params)
  @new_member_obj.save
  erb( :"members/member_created" )
end

# show info of a particular member
get '/members/:id' do
  @member = Member.find(params['id'].to_i)
  erb( :"members/show" )
end

# edit particular members info
get '/members/:id/edit' do
  @member = Member.find(params['id'].to_i)
  erb( :"members/edit" )
end

post '/members/:id' do
  member_obj_to_update = Member.new(params)
  member_obj_to_update.update
  erb( :"members/updated" )

end








#
