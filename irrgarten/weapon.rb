#encoding:utf-8
# frozen_string_literal: true
class Weapon
  # Constructor de la clase
  # param p = power
  # param u = uses
  def initialize(p,u)
    @power = p
    @uses = u
  end

  def attack()
    if (@uses > 0)
      @uses -= 1
      return @power

    else
      return (0)
    end
  end

  def to_s()
    return "W[#{@power},#{@uses}]"
  end

  def discard()
    return Dice.discard_element(@uses)
  end


end
