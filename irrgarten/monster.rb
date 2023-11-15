#encoding:utf-8

class Monster
  @@INITIAL_HEALTH = 5

  def initialize(name, intelligence, strength)
    @name = name
    @intelligence = intelligence
    @strength = strength
    @health = @@INITIAL_HEALTH
    @row = 0
    @col = 0
  end

  def dead
    @health <= 0.0
  end

  def attack
    Dice.intensity(@strength)
  end

  def defend(received_attack)
    is_dead = dead
    unless is_dead #if (!is_dead)
      defensive_energy = Dice.intensity(@intelligence)

      if defensive_energy < received_attack {
        got_wounded
        is_dead = dead
      }
      end
    end
  end

  def set_pos(row, col)
    @col = col
    @row = row
  end

  def to_s
    "Name: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}\n"
  end

  def got_wounded
    @health -= 1
  end
end


