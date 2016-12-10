
require('./lib/farkle')
require('sinatra')
require('sinatra/reloader')
require "pry-nav"
also_reload('lib/**/*.rb')


get '/'  do
  @player1 = Farkle.new [0,0,0,0,0]
  @player1.create_player
  @player1.roll
  erb :index
end

get '/roll' do
  @player1 = Farkle.active_player
  # binding.pry
  @player1.roll
  erb :index
end

post '/' do
  @player1 = Farkle.active_player
  selection = params['active_dice'].to_i

  method = params.fetch 'method'
  if method.eql? 'freeze'
    @player1.freeze selection
  # elsif method.eql? 'bank'
  #   @player1.bank
  end
  erb :index
end
