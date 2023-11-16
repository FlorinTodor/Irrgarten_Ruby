#encoding:utf-8
# frozen_string_literal: true
require_relative 'dice'
module Irrgarten
class Weapon
  # Constructor de la clase
  # param p = power
  # param u = uses
  def initialize(p,u)
    @power = p
    @uses = u
  end

  def attack
    if @uses > 0
      @uses -= 1
      return @power
    else
      return 0
    end
  end

  def to_s
    "W[Power: #{@power}, Uses: #{@uses}]"
  end

  def discard
    Dice.discard_element(@uses)
  end
end
end