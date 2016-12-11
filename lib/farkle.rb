@@player = nil;

class Farkle
  define_method(:initialize) do |active_dice|
    @active_dice = active_dice
    @frozen_dice = []
    @hand_score = 0
    @strikes = 0
    @banked = 0
    @turn_in_process = true
    @message = ''
  end

  define_singleton_method(:active_player) do
    @@player
  end
  define_singleton_method(:end_turn) do
    @@player
  end

  define_method(:create_player) do
    @@player = self
  end

  define_method(:turn_in_process) do
    @turn_in_process
  end

  define_method(:active_dice) do
    @active_dice
  end
  define_method(:hand_score) do
    @hand_score = score(@active_dice)
  end

  define_method(:frozen_dice) do
    @frozen_dice
  end

  define_method(:frozen_score) do
    score(@frozen_dice)
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
    if @active_dice.count(n) >=3   #triple
      @message = ('you froze ' + @active_dice.count(n).to_s + ' ' + n.to_s + 's')

      @active_dice.count(n).times do
        @active_dice.delete_at(@active_dice.index(n))
        @frozen_dice.push(n)
      end

      if @active_dice.length.eql?(0)
        @message = 'Hot dice! Roll Again!'
        @active_dice.fill(0,0,5)
      end
    elsif n.eql? 1 or  n.eql? 5    #single one or five
      @message = 'you froze a ' + n.to_s

      @active_dice.delete_at(@active_dice.index(n))
      @frozen_dice.push(n)
      if @active_dice.length.eql?(0)
        @message = 'Hot dice! Roll Again!'
        @active_dice.fill(0,0,5)
      end
    else #non-scoring dice
      @message = "You can't freeze non-scoring dice"
    end
  end

  define_method(:roll) do
    @message = ''
    if !@turn_in_process
      @active_dice.fill(0,0,5)
      @turn_in_process = true
    end
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
        @turn_in_process = false
      else
        @hand_score = 0
        @frozen_dice = []
        @message = 'Strike ' + @strikes.to_s
        @turn_in_process = false
      end
    else
      @hand_score = 0
      @active_dice
    end
  end

  define_method(:bank) do
    @banked += score(@frozen_dice)
    @message = 'You banked '+score(@frozen_dice).to_s + ' for a new bank of '+ @banked.to_s
    @frozen_dice = []
    @turn_in_process = false
  end
end
