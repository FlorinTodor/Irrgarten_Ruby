#encoding:utf-8
# frozen_string_literal: true
require_relative 'dice'

class Weapon
  # Constructor de la clase
  # param p = power
  # param u = uses
  def initialize(p,u)
    @power = p
    @uses = u
  end

  def attack
    if (@uses > 0)
      @uses -= 1
      @power

    else
      0
    end
  end

  def to_s
    "W[Power: #{@power}, Uses: #{@uses}]"
  end

  def discard
    Dice.discard_element(@uses)
  end


end
