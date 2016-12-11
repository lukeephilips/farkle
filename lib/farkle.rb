@@players = [];

class Farkle
  define_method(:initialize) do |active_dice|
    @active_dice = active_dice
    @frozen_dice = []
    @hand_score = 0
    @strikes = 0
    @banked = 0
    @turn_status = 'can_roll'
    @message = ''
    @id = @@players.count + 1
  end

  # define_singleton_method(:change_player) do
  #   @@players
  # end
  define_singleton_method(:active_player) do
    @@players
  end

  define_singleton_method(:find) do |identifier|
    found_player = nil
    @@players.each do |player|
      if player.id.eql?(identifier.to_i())
        found_player = player
      end
    end
      found_player
  end

  define_method(:create_player) do
    @@players.push(self)
  end
  define_method(:id) do
    @id
  end

  define_method(:turn_status) do
    @turn_status
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
      @turn_status = 'can_roll'
      # @message = ''

    elsif n.eql? 1 or  n.eql? 5    #single one or five
      @message = 'you froze a ' + n.to_s

      @active_dice.delete_at(@active_dice.index(n))
      @frozen_dice.push(n)
      if @active_dice.length.eql?(0)
        @message = 'Hot dice! Roll Again!'
        @active_dice.fill(0,0,5)
      end
      @turn_status = 'can_roll'
    else #non-scoring dice
      @message = "You can't freeze non-scoring dice"
    end
  end

  define_method(:roll) do
    @message = ''
    if @turn_status == 'over'
      @active_dice.fill(0,0,5)
      @turn_status = 'can_roll'
    end

    if @turn_status == 'must_freeze_to_roll'
      @message = 'Freeze at least one die to roll'
    else
      @active_dice.length.times do |i|
        @active_dice[i] = rand(6) + 1
      end

      @turn_status = 'must_freeze_to_roll'
      if score(@active_dice) == 0
        @strikes += 1
        if @strikes == 3
          @banked = 0
          @strikes = 0
          @frozen_dice = []
          @message = 'Farkle'
          @turn_status = 'over'
        else
          @hand_score = 0
          @frozen_dice = []
          @message = 'Strike ' + @strikes.to_s
          @turn_status = 'over'
        end
      else
        @hand_score = 0
        @active_dice
      end
    end
  end

  define_method(:bank) do
    @banked += score(@frozen_dice)
    @message = 'You banked '+score(@frozen_dice).to_s + ' for a new bank of '+ @banked.to_s
    @frozen_dice = []
    @turn_status = 'over'
  end
end
