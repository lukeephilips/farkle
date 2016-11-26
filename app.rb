
require('./lib/farkle')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')

get('/') do
  @active_dice = [0,0,0,0,0].roll()
  erb(:index)
end
