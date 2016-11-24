# d1 = 0
# d2 = 0
# d3 = 2
# d4 = 2
# d5 = 3
# d6 = 6
# output = ""


class Array
  # def initialize(active_dice, frozen_dice, strikes, bank)
  #   active_dice = active_dice
  #   frozen_dice = frozen_dice
  #   strikes = strikes
  #   bank = bank
  #   binding.pry
  # end
    active_dice = [0,0,0,0,0]
    frozen_dice = []
    strikes = 0
    bank = 0

  define_method(:score) do
    score = 0
# triples
    [2,3,4,6].each do |n|
      if self.count(n) >= 3
        score += (n * 100)
        if self.count(n) > 3
          score += (self.count(n) - 3) * n * 50
        end
      end
    end
# ones
    if self.count(1) >= 3
      score += 1000
      if self.count(1) > 3
         score += (self.count(1) - 3) * 500
       end
    else
      score += self.count(1)* 100
    end
#fives
    if self.count(5) >= 3
      score += 500
      if self.count(1) > 3
        score += (self.count(1) - 3) * 2500
      end
    elsif
      score += self.count(5)* 50
    end
    score
  end

  define_method(:freeze) do |n|
    if self[n] == 1 or  self[n] == 5
      frozen_dice.push(self.delete_at(n))
      "frozen score: "+ frozen_dice.score.to_s + " new active dice " + active_dice.to_s
    elsif self.count(self[n]) >=3
      # binding.pry
      frozen_dice.concat(self.select {|die| die == (self[n])})
      self.delete(self[n])
      "frozen score: " + frozen_dice.score.to_s + " active dice " + active_dice.to_s
    elsif frozen_dice.include?(self[n])
      frozen_dice.push(self.delete_at(n))
      "frozen score: " + frozen_dice.score.to_s + " active dice " + active_dice.to_s
    else
      "you can't freeze non-scoring dice"
    end
  end

  define_method(:roll) do
    self.length.times do |i|
      self[i] = rand(6) + 1
    end
    if self.score == 0
      strikes += 1
      if strikes == 3
        bank = 0
        strikes = 0
        frozen_dice = []
        puts 'Farkle'
        active_dice = [0,0,0,0,0].roll
      else
        score = 0
        frozen_dice = []
        puts 'Strike ' + strikes.to_s
        active_dice = [0,0,0,0,0].roll
      end
    else
      score = 0
      self
    end
  end

  define_method(:hot_dice) do
    if active_dice.length == 0
      active_dice = [0,0,0,0,0].roll
    end
  end

  define_method(:bank) do
    bank += frozen_dice.score
    frozen_dice = []
    active_dice = [0,0,0,0,0].roll
  end
  binding.pry
end
# game = Farkle. new([],[],0,0)
