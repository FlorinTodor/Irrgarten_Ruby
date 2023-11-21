# frozen_string_literal: true
module Irrgarten
require_relative 'player'
require_relative 'dice'

class Fuzzy_player < Player
  def initialize(other)
    @name = other.name
    @intelligence = other.intelligence
    @strength = other.strength
    @health = other.health
    @row = other.row
    @col = other.col
    @number = other.number
    @consecutive_hits = other.consecutive_hits
    @weapons = other.weapons
    @shields = other.shields
  end


  def move(direction,valid_moves)
    movimientoComoUnPlayer = super(direction,valid_moves);
    movimientoComoUnFuzzyPlayer = Dice.next_step(movimientoComoUnPlayer,valid_moves,@intelligence);
    movimientoComoUnFuzzyPlayer
  end


  def attack
    Dice.intensity(@strength + sum_weapons)
  end

  def defensive_energy
    Dice.intensity(@intelligence + sum_shields)
  end

  def to_s
    "Fuzzy: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}, Weapons: #{@weapons.to_s}, Shields: #{@shields.to_s}\n"
  end


end
end

