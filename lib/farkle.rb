class Array
  # define_method(:initialize)
  #   @active_dice = [0,0,0,0,0]
  #   @frozen_dice = []
  #   @strikes = 0
  #   @bank = 0
  # end

  active_dice = [0,0,0,0,0]
  frozen_dice = []
  strikes = 0
  bank = 0

  define_method(:score) do
    score = 0
    [1..6].each do |n|
      if self.count(n) >= 3
        if n.eql?(1)
          score += (1000) + (self.count(n) - 3) * n * 500
        else
          score += (n * 100) + (self.count(n) - 3) * n * 50
        end
      elsif n.eql?(1)
        score += self.count(1)* 100
      elsif n.eql?(5)
        score += self.count(5)* 50
      end
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
    # elsif frozen_dice.include?(self[n])
    #   frozen_dice.push(self.delete_at(n))
    #   "frozen score: " + frozen_dice.score.to_s + " active dice " + active_dice.to_s
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
