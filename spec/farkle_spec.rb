require('rspec')
require('pry')
require('pry-nav')
require ("farkle")

describe(Farkle) do
  describe('#initialize') do
    it('returns an array of empty dice') do
      test_game = Farkle.new([0,0,0,0,0])
      expect(test_game.active_dice).to(eq([0,0,0,0,0]))
    end
  end
  describe('#initialize') do
    it('returns specific dice when given') do
      test_game = Farkle.new([1,5,0,0,0])
      expect(test_game.active_dice).to(eq([1,5,0,0,0]))
    end
  end

  describe('#score') do
    it('returns 0 score for an array of empty dice') do
      test_game = Farkle.new([0,0,0,0,0])
      expect(test_game.score(test_game.active_dice)).to(eq(0))
    end
  end
  describe('#score') do
    it('returns 150 for an array with a 1 and 5') do
      test_game = Farkle.new([1,5,0,0,0])
      expect(test_game.score(test_game.active_dice)).to(eq(150))
    end
  end
  describe('#score') do
    it('returns 1000 score for an array with triple ones') do
    test_game = Farkle.new([1,1,1,0,0])
    expect(test_game.score(test_game.active_dice)).to(eq(1000))
    end
  end
  describe('#score') do
    it('returns 600 score for a standard triple') do
    test_game = Farkle.new([4,4,4,4,0])
    expect(test_game.score(test_game.active_dice)).to(eq(600))
    end
  end
  describe('#score') do
    it('returns a score for an array of mixed scoring types') do
    test_game = Farkle.new([4,4,4,4,1])
    expect(test_game.score(test_game.active_dice)).to(eq(700))
    end
  end

  describe('#freeze') do
    it('freezes one scoring die') do
    test_game = Farkle.new([1,5,0,0,0])
    expect(test_game.freeze(0)).to(eq([1]))
    end
  end
  describe('#freeze') do
    it('freezes triple') do
    test_game = Farkle.new([1,5,2,2,2])
    expect(test_game.freeze(3)).to(eq([2,2,2]))
    end
  end
  describe('#freeze') do
    it('does not freeze a non-scoring die') do
    test_game = Farkle.new([1,5,4,2,3])
    expect(test_game.freeze(2)).to(eq("You can't freeze non-scoring dice"))
    end
  end
  describe('#freeze') do
    it('if the user freezes the last remaining die, give 5 new dice') do
    test_game = Farkle.new([1])
    expect(test_game.freeze(0).length).to(eq(5))
    end
  end
  describe('#score') do
    it('returns a score for an array of mixed scoring types') do
    test_game = Farkle.new([4,4,4,4,1])
    expect(test_game.score(test_game.active_dice)).to(eq(700))
    end
  end

  describe('#roll') do
    it('returns randomized roll from empty dice') do
    test_game = Farkle.new([0,0,0,0,0])
    expect(test_game.roll()).not_to include(0)
    end
  end
end
