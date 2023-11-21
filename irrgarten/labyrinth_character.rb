# frozen_string_literal: true
module Irrgarten


class Labyrinth_character
  attr_accessor :name, :intelligence, :strength, :health, :row, :col
  def initialize(name,intelligence,strength,health,row,col)
    @name = name
    @intelligence = intelligence
    @strength = strength
    @health = health
    @row =row
    @col =col
  end

  def copy_attributes(other)
    @name = other.name
    @intelligence = other.intelligence
    @strength = other.strength
    @health = other.health
    @row = other.row
    @col = other.col
  end

  def dead()
    @health <= 0.0
  end
  def get_row
    @row
  end
  def set_row(row)
    @row = row
  end
  def name
    @name
  end

  def set_name(name)
    @name = name
  end

  def intelligence
    @intelligence
  end

  def set_intelligence(intelligence)
    @intelligence = intelligence
  end

  def strength
    @strength
  end

  def set_strength(strength)
    @strength = strength
  end

  def health
    @health
  end

  def set_health(health)
    @health = health
  end

  def row
    @row
  end

  def col
    @col
  end

  def set_pos(row, col)
    @row = row
    @col = col
  end

  def to_s
    raise NotImplementedError, "Las subclases deben implementar el método 'atacar'"
  end

  def got_wounded
    @health -= 1
  end

  def attack
    raise NotImplementedError, "Las subclases deben implementar el método 'atacar'"
  end

  def defender(ataque)
    raise NotImplementedError, "Las subclases deben implementar el método 'defender'"
  end



end
end