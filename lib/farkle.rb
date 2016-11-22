# d1 = 0
# d2 = 0
# d3 = 2
# d4 = 2
# d5 = 3
# d6 = 6
# output = ""


class Farkle
  def initialize(active_dice, frozen_dice, strikes, bank)
    @active_dice = active_dice
    @frozen_dice = frozen_dice
    @strikes = strikes
    @bank = bank
    binding.pry
  end


  define_method(:score) do
    hand_score = 0
# triples
    [2,3,4,6].each do |n|
      if self.count(n) >= 3
        hand_score += (n * 100)
        if self.count(n) > 3
          hand_score += (self.count(n) - 3) * n * 50
        end
      end
    end
# ones
    if self.count(1) >= 3
      hand_score += 1000
      if self.count(1) > 3
         hand_score += (self.count(1) - 3) * 500
       end
    else
      hand_score += self.count(1)* 100
    end
#fives
    if self.count(5) >= 3
      hand_score += 500
      if self.count(1) > 3
        hand_score += (self.count(1) - 3) * 2500
      end
    elsif
      hand_score += self.count(5)* 50
    end
    hand_score
  end

  define_method(:freeze_die) do |n|
    @frozen_dice.push(self.delete_at(n))
    @frozen_dice.score
  end

  define_method(:roll_dice!) do
    self.length.times do |i|
      self[i] = rand(6) + 1
    end
    if self.score == 0
      @strikes += 1
      if @strikes == 3
        @bank = 0
        roll_output = 'Farkle'
      else
      roll_output = 'Strike ' + @strikes
      end
    else
      roll_output = "dice: " + self.to_s + " score: " + self.score.to_s
    end
  end
end

define_method(:bank) do
  @bank += @frozen_dice.score
  @frozen_dice = []
  @active_dice = []
end
game = Farkle. new([],[],0,0)
