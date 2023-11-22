# frozen_string_literal: true
module Irrgarten
require_relative 'player'
require_relative 'dice'

class Fuzzy_player < Player
  def initialize(other)
    copy_from(other)
  end

  def informacion
    puts @name + @number + @intelligence.to_s + @strength.to_s + @health.to_s + @row.to_s  + @col.to_s + @consecutive_hits.to_s
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
    "Fuzzy: " + super()
    end

end
end

