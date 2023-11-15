#encoding:utf-8
#player.rb

require_relative 'directions'
require_relative 'dice'
require_relative 'shield'
require_relative 'weapon'
module Irrgarten
class Player
  attr_reader :number
  @@MAX_WEAPONS = 5
  @@MAX_SHIELDS = 3
  @@INITIAL_HEALTH = 10
  @@HITS2LOSE = 3


  def initialize(number, intelligence, strength)
    @number = number
    @name = "Player ##{number}"
    @intelligence = intelligence
    @strength = strength
    @health = @@INITIAL_HEALTH
    @weapons = Array.new(@@MAX_WEAPONS)
    @shields = Array.new(@@MAX_SHIELDS)
    @row = 0
    @col = 0
    @consecutive_hits = 0
  end

  def resurrect
    @weapons.clear
    @shields.clear
    @health = @@INITIAL_HEALTH
    @consecutive_hits = 0
  end

  def get_row
    @row
  end

  def get_col
    @col
  end

  def get_number
    @number
  end

  def set_pos(row,col)
    @row = row
    @col = col
  end

  def dead
    @health <= 0.0
  end

  def move(direction, valid_moves)
    size = valid_moves.size
    contained = valid_moves.contains(direction)

    if size > 0 && !contained
      firs_element = valid_moves[0]
      return firs_element
    else
      return direction
    end
  end

  def attack
    @strength + sum_weapons
  end

  def defend(received_attack)
    manage_hit(received_attack)
  end

  def receive_reward
    w_reward = Dice.weapons_reward
    s_reward = Dice.shields_reward

    for i in 0..w_reward
      wnew = new_weapon
      receive_weapon(wnew)
    end

    for i in 0..s_reward
      snew = new_shield
      receive_shield(snew)
    end

    extra_health = Dice.health_reward
    @health += extra_health
  end

  def to_s
    "Name: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row},
      Col: #{@col}, Weapons: #{@weapons.to_s}, Shields: #{@shields.to_s}\n"
  end

  private

  def receive_weapon(weapon)
    for i in 0..@weapons.size
      wi = @weapons[i]
      discard = wi.discard

      if discard
        @weapons.delete_at(i)
      end
    end

    size = @weapons.size
    if size < @@MAX_WEAPONS
      @weapons.push(weapon)
    end
  end

  def receive_shield(shield)
    for i in 0..@shields.size
      si = @shields[i]
      discard = si.discard

      if discard
        @shields.delete_at(i)
      end
    end

    size = @shields.size

    if size < @@MAX_WEAPONS
      @weapons.push(shield)
    end
  end

  def new_weapon
    # Almacenamos el poder y el número de usos del nuevo arma
    power = Dice.weapon_power
    uses = Dice.uses_left

    # Creamos un nuevo arma
    new_weapon = Weapon.new(power, uses)

    # Guardamos el nuevo arma
    @weapons.push(new_weapon)

    new_weapon
  end

  def new_shield
    # Almacenamos la protección y el número de usos del nuevo escudo
    protection = Dice.shield_power
    uses = Dice.uses_left

    # Creamos un nuevo escudo
    new_shield = Shield.new(protection, uses)

    # Guardamos el nuevo escudo
    @shields.push(new_shield)

    new_shield
  end

  def sum_weapons
    sum = 0.0
    for weapon in @weapons
      sum += weapon.attack
    end
    sum
  end

  def sum_shields
    sum = 0.0
    for shield in @shields
      sum += shield.protect
    end
    sum
  end

  def defensive_energy
    @intelligence + sum_shields
  end

  def manage_hit(received_attack)
    lose = false
    defense = defensive_energy

    if defense < received_attack
      got_wounded
      inc_consecutive_hits
    else
      reset_hits
    end

    if @consecutive_hits == @@HITS2LOSE || dead
      reset_hits
      lose=true
    end

    lose
  end

  def reset_hits
    @consecutive_hits = 0
  end

  def got_wounded
    @health -= 1
  end

  def inc_consecutive_hits
    @consecutive_hits += 1
  end
end
end