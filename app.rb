
require('./lib/farkle')
require('sinatra')
require('sinatra/reloader')
require "pry-nav"
also_reload('lib/**/*.rb')


get '/'  do

  erb :index
end

post '/farkle'  do
players = params['player-count'].to_i
players.times do
  Farkle.new([0,0,0,0,0]).create_player
  @player = Farkle.active_player[0]
end
  erb :farkle
end

get '/roll' do
  @player = Farkle.active_player[0]
  @player.roll
  erb :farkle
end

post '/' do
  @player = Farkle.active_player[0]
  selection = params['active_dice'].to_i

  method = params.fetch 'method'
  if method.eql? 'freeze'
    @player.freeze(selection)
  elsif method.eql? 'bank'
    @player.bank
  end
  erb :farkle
end
