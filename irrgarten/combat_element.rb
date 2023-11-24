#encoding:utf-8
require_relative 'dice'
module Irrgarten
class Combat_element
  attr_reader :effect, :uses

  def initialize(effect, uses)
    @effect = effect
    @uses = uses
  end

  def produce_effect
    if get_uses > 0
      set_uses(get_uses - 1)
      return @effect
    else
      return 0.0
    end
  end

  def get_uses
    @uses
  end

  def set_uses(uses)
    @uses = uses
  end

  def discard
    Dice.discard_element(@uses)
  end


  private_class_method :new
end
end
