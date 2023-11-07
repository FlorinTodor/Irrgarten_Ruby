# frozen_string_literal: true

class Shield
  @protection = 0.0
  @uses = 0

  def initialize(p,u)
    @protection = p
    @uses = u
  end

  def protect()
    if (@uses > 0)
      @uses -= 1
      return (@protection)

    else
      return(0)
    end

  end

  def to_s
    return "S[#{@protection},#{@uses}]"
  end

  def discard()
    return Dice.discard_element(@uses)
  end
end