# frozen_string_literal: true
module Irrgarten
require_relative 'player'
require_relative 'dice'

class Fuzzy_player < Player
  public
  def copy(other)
    super
  end

  def initialize(other)
    copy(other)
  end

  def move(direction,valid_moves)
    movimientoComoUnPlayer = super(direction,valid_moves);
    movimientoComoUnFuzzyPlayer = Dice.next_step(movimientoComoUnPlayer,valid_moves,@intelligence);
    movimientoComoUnFuzzyPlayer
  end

  def attack
    Dice.intensity(@strength + sum_weapons)
  end


  def to_s
    "Fuzzy: Name: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}, Weapons: #{@weapons}, Shields: #{@shields}\n"
  end

  protected
  def defensive_energy
    Dice.intensity(@intelligence + sum_shields)
  end

end
end