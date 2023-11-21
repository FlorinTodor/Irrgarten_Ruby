#encoding:utf-8
require_relative 'dice'
require_relative 'labyrinth_character'

module Irrgarten
class Monster < Labyrinth_character
  @@INITIAL_HEALTH = 5

  def initialize(name, intelligence, strength)
    super(name,intelligence,strength,@@INITIAL_HEALTH,0,0)
  end

  def attack
    Dice.intensity(@strength)
  end

  def defend(received_attack)
    is_dead = dead
    unless is_dead #if (!is_dead)
      defensive_energy = Dice.intensity(@intelligence)

      if defensive_energy < received_attack
        got_wounded
        is_dead = dead
      end
    end
     is_dead
  end


  def to_s
    "Name: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}\n"
  end

end
end

