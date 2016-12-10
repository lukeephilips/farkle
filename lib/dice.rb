class Dice
  attr_reader(:die1,:die2,:die3,:die4,:die5,:die6)
  def initialize()
    @die1 = 0
    @die2 = 0
    @die3 = 0
    @die4 = 0
    @die5 = 0
    @die6 = 0
  end

def dice_array
  [@die1,@die2,@die3,@die4,@die5,@die6]
end

def score(array)
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

end
