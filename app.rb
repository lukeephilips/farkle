get('/') do
  erb(:index)
  @active_dice = params.fetch('dice').
end
