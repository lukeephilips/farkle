require('rspec')
require('pry')
require "farkle"

describe('Array#score') do
  it('gives a score of zero for empty dice') do
    expect([0,0,0,0,0].score).to(eq(0))
  end
  it('gives a score of 50 for one 5') do
    expect([5,0,0,0,0].score).to(eq(50))
  end
  it('gives a score of 600 for four 5s') do
    expect([5,5,5,5,0].score).to(eq(500))
  end
end

# describe('Array#roll_dice!') do
#   it('replaces all active dice with 1') do
#     expect([0,0,0,0,0].roll_dice!).to(eq([1,1,1,1,1]))
#   end
#   it('replaces all active dice with 0 and returns FARKLE') do
#     expect([5,5,5,5,0].roll_dice!).to(eq('FARKLE'))
#   end
# end
