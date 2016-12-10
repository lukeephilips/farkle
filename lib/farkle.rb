@@player = nil;

# attr_reader(:active_dice, :frozen_dice, :hand_score, :strikes, :bank, :message)
class Farkle
  define_method(:initialize) do |active_dice|
    @active_dice = active_dice
    @frozen_dice = []
    @hand_score = 0
    @strikes = 0
    @banked = 0
    @message = ''
    # @active_dice.length.times do |i|
    #   @active_dice[i] = rand(6) + 1
    # end
  end
  define_method(:create_player) do
    @@player = self
  end
  define_singleton_method(:active_player) do
    @@player
  end

  define_method(:active_dice) do
    @active_dice
  end
  define_method(:frozen_dice) do
    @frozen_dice
  end

  define_method(:frozen_score) do
    score(@frozen_dice)
  end
  define_method(:hand_score) do
    @hand_score = score(@active_dice)
  end

  define_method(:strikes) do
    @strikes
  end
  define_method(:banked) do
    @banked
  end
  define_method(:message) do
    @message
  end

  define_method(:score) do |array|
    score = 0
    (1..6).each.with_index do |n, index|
      if array.count(n) >= 3
        if n.eql?(1)
          score += (1000) + (array.count(n) - 3) * n * 500
        else
          score += (n * 100) + (array.count(n) - 3) * n * 50
        end
      elsif index.eql?(0)
        score += array.count(1)* 100
      elsif index.eql?(4)
        score += array.count(5)* 50
      end
    end
    score
  end

  define_method(:freeze) do |n|
    if n.eql? 1 or  n.eql? 5    #single one or five
      @message = 'you froze a ' + n.to_s
      @frozen_dice.push(n)
      @active_dice.delete_at(n)
      if @active_dice.length.eql?(0)
        @active_dice.fill(0,0,5)
        # self.roll
      # else
      #   @frozen_dice

      end
    elsif @active_dice.count(@active_dice[n]) >=3   #triple
      binding.pry

      @message = 'you froze ' + @active_dice.count(@active_dice[n]).to_s + 's'

      @frozen_dice.concat(@active_dice.select {|die| die == (@active_dice[n])})
      @active_dice.delete(@active_dice[n])
      if @active_dice.length.eql?(0)
        @active_dice.fill(0,0,5)
        # self.roll
      # else
      #   @frozen_dice
      end
    else #non-scoring dice
      @message = "You can't freeze non-scoring dice"
    end
  end

  define_method(:roll) do
    @message = ''
    @active_dice.length.times do |i|
      @active_dice[i] = rand(6) + 1
    end
    if score(@active_dice) == 0
      @strikes += 1
      if @strikes == 3
        @banked = 0
        @strikes = 0
        @frozen_dice = []
        @message = 'Farkle'
        @active_dice.fill(0,0,5)
      else
        @hand_score = 0
        @frozen_dice = []
        @message = 'Strike ' + @strikes.to_s
        @active_dice.fill(0,0,5)
      end
    else
      @hand_score = 0
      @active_dice
    end
  end

  define_method(:bank) do
    binding.pry
    @banked += score(@frozen_dice)
    @frozen_dice = []
    @active_dice.fill(0,0,5)
    @message = 'You banked '+score(@frozen_dice).to_s + ' for a new bank of '+ @banked.to_s
    # self.roll
  end
end
