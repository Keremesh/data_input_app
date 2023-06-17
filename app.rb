require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/database_connection'
require_relative './lib/admin_repo'
# require_relative './lib/user_repository'
require 'bcrypt'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
 # Declares a route that responds to a request with:
  #  - a GET method
  #  - the path /
  get '/' do
        # repo = AdminRepository.new
        # @admins = repo.all
        return erb(:index)
    # The code here is executed when a request is received and we need to 
    # send a response. 

    # We can return a string which will be used as the response content.
    # Unless specified, the response status code will be 200 (OK).
    # return 'Some response data'
  end
end