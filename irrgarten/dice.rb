#encoding:utf-8
#frozen_string_literal: true
module Irrgarten
class Dice
  #DECLARACIÓN DE LOS ATRIBUTOS DE CLASE DE DICE
  # LOS ATRIBUTOS EN RUBY SIEMPRE SON PRIVADOS
  #
  @@MAX_USES = 5  #(número máximo de usos de armas y escudos)
  @@MAX_INTELLIGENCE = 10.0 #(valor máximo para la inteligencia de jugadores y monstruos)
  @@MAX_STRENGHT = 10.0 #(valor máximo para la fuerza de jugadores y monstruos)
  @@RESURRECT_PROB = 0.3 #(probabilidad de que un jugador sea resucitado en cada turno)
  @@WEAPONS_REWARD = 2 #(numero máximo de armas recibidas al ganar un combate)
  @@SHIELDS_REWARD = 3 #(numero máximo de escudos recibidos al ganar un combate)
  @@HEALTH_REWARD = 5 #(numero máximo de unidades de salud recibidas al ganar un combate)
  @@MAX_ATTACK = 3 #(máxima potencia de las armas)
  @@MAX_SHIELD = 2 #(máxima potencia de los escudos)
  @@GENERATOR = Random.new

  def self.random_pos(max)
    return @@GENERATOR.rand(max)
  end

  def self.who_starts(nplayers)
    return @@GENERATOR.rand(nplayers)
  end

  def self.random_intelligence
    return @@GENERATOR.rand * @@MAX_INTELLIGENCE
  end

  def self.random_strength
    return @@GENERATOR.rand * @@MAX_STRENGHT
  end

  def self.resurrect_player
    return @@GENERATOR.rand <= @@RESURRECT_PROB
  end

  def self.weapons_reward
    return @@GENERATOR.rand(@@WEAPONS_REWARD)
  end

  def self.shields_reward
    return @@GENERATOR.rand(@@SHIELDS_REWARD)
  end

  def self.health_reward
    return @@GENERATOR.rand(@@HEALTH_REWARD)

  end

  def self.weapon_power
    return @@GENERATOR.rand * @@MAX_ATTACK
  end

  def self.shield_power
    return @@GENERATOR.rand * @@MAX_SHIELD
  end

  def self.uses_left
    return @@GENERATOR.rand(@@MAX_USES)
  end

  def self.intensity(competence)
    return @@GENERATOR.rand * competence
  end

  def self.discard_element(uses_left)

    return false if uses_left == @@MAX_USES # Caso extremo: máximo número de usos
    return true if uses_left == 0 # Caso extremo: 0 usos

    # Calcular la probabilidad inversamente proporcional
    probabilidad = uses_left.to_f / @@MAX_USES.to_f

    # Si el número aleatorio es menor que la probabilidad, devolver true
    return @@GENERATOR.rand > probabilidad
  end
end
end