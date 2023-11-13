#encoding:utf-8

class Player
  @@MAX_WEAPONS = 5
  @@MAX_SHIELDS = 3
  @@INITIAL_HEALTH = 10
  @@HITS2LOSE = 3


  def initialize(number, intelligence, strength)
    @number = number
    @name = "Player # #{number}"
    @intelligence = intelligence
    @strength = strength #prueba github
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

  def dead
    @health <= 0
  end

  def move(direction, valid_moves)
    raise NotImplementedError, 'This method is not implemented yet.'
  end

  def attack
    @strength + sum_weapons
  end

  def defend(received_attack)
    manage_hit(received_attack)
  end

  def receive_reward
    raise NotImplementedError
  end

  def to_s
    "Player [name: #{@name}, intelligence: #{@intelligence}, strength: #{@strength}, health: #{@health}, row: #{@row}, col: #{@col}, weapons: #{@weapons.to_s}, shields: #{@shields.to_s}]"
  end

  private

  def receive_weapon(weapon)
    raise NotImplementedError
  end

  def receive_shield(shield)
    raise NotImplementedError
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
    sum = 0
    for weapon in @weapons
      sum += weapon.attack
    end
    sum
  end

  def sum_shields
    sum = 0
    for shield in @shields
      sum += shield.protect
    end
    sum
  end

  def defensive_energy
    @intelligence + sum_shields
  end

  def manage_hit(received_attack)
    raise NotImplementedError
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
