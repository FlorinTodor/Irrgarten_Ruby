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
    @effect
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
