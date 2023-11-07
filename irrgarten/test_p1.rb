# frozen"_string_literal: true
require_relative "directions"
require_relative 'dice'
require_relative 'game_character'
require_relative 'game_state'
require_relative 'orientation'
require_relative 'shield'
require_relative 'weapon'

class Test_p1

  #CREAR INSTANCIAS DE LA CLASE WEAPON
  weapon1 = Weapon.new(0.7,3)
  weapon2 = Weapon.new(0.3,2)
  weapon3 = Weapon.new(0.5,1)
  weapon4 = Weapon.new(0.1,1)

  #CREAR INSTANCIAS DE LA CLASE SHIELD
  shield1 = Shield.new(0.7,3)
  shield2 = Shield.new(0.3,2)
  shield3 = Shield.new(0.8,2)
  shield4 = Shield.new(0.1,1)

  # Ejemplo de uso de métodos de la clase WEAPON
  puts "PRUEBAS DE LA CLASE WEAPON:\n"
  puts "\tCOMPROBRACIÓN DEL METODO ATTACK DE WEAPON1   :  #{weapon1.attack}"
  puts "\tCOMPROBRACIÓN DEL METODO ATTACK DE WEAPON2   :  #{weapon2.attack}"
  puts "\tCOMPROBRACIÓN DEL METODO DISCARD DE WEAPON3  :  #{weapon3.discard}"
  puts "\tCOMPROBRACIÓN DEL METODO TO_S DE WEAPON3     :  #{weapon3.to_s}"
  puts "\tCOMPROBRACIÓN DEL METODO TO_S DE WEAPON4     :  #{weapon4.to_s}"

  # Ejemplo de uso de métodos de la clase SHIELD
  puts "\nPRUEBAS DE LA CLASE SHIELD:\n"
  puts "\tCOMPROBRACIÓN DEL METODO PROTECT DE SHIELD1   :  #{shield1.protect}"
  puts "\tCOMPROBRACIÓN DEL METODO PROTECT DE SHIELD2   :  #{shield2.protect}"
  puts "\tCOMPROBRACIÓN DEL METODO DISCARD DE SHIELD3   :  #{shield3.discard}"
  puts "\tCOMPROBRACIÓN DEL METODO TO_S DE SHIELD3      :  #{shield3.to_s}"
  puts "\tCOMPROBRACIÓN DEL METODO TO_S DE SHIELD4      :  #{shield4.to_s}"

  #EJEMPLO DE USO DE LOS ENUMERADOS CREADOS
  puts "\nPRUEBAS DE LOS ENUMERADOS:\n"
  puts "\tCOMPROBACION DEL ENUMERADO Directions     : #{Directions::RIGHT}"
  puts "\tCOMPROBACION DEL ENUMERADO Game_character : #{Game_character::MONSTER}"
  puts "\tCOMPROBACION DEL ENUMERADO Orientation    : #{Orientation::HORIZONTAL}"

  #EJEMPLO DE LA CLASE Game_state
  puts "\nPRUEBA DE LOS MÉTODOS DE LA CLASE GAMESTATE:\n"
  game = Game_state.new("laberinto","jugadores","mounstruos",1,true,"eventos")
  puts "\tATRIBUTO LABYRINTH      : "+ game.labyrinthv
  puts "\tATRIBUTO PLAYERS        : "+ game.players
  puts "\tATRIBUTO MONSTERS       : "+ game.monsters
  puts "\tATRIBUTO CURRENTPLAYER  :  #{game.current_player}"
  puts "\tATRIBUTO WINNER         :  #{game.winner}"
  puts "\tATRIBUTO LOG            : "+ game.log

  #EJEMPLO DE LA CLASE Dice

  puts "\nPRUEBA DE LOS MÉTODOS DE LA CLASE DICE:\n"

  total_calls = 100

  for i in 1..total_calls
    puts "PRUEBA Nº#{i}"

    puts "\tCOMPROBACION DEL METODO randomPos          : #{Dice.random_pos(i)}"
    puts "\tCOMPROBACION DEL METODO whoStarts          : #{Dice.who_starts(i)}"
    puts "\tCOMPROBACION DEL METODO randomIntelligence : #{Dice.random_intelligence()}"
    puts "\tCOMPROBACION DEL METODO randomStrength     : #{Dice.random_strength()}"
    puts "\tCOMPROBACION DEL METODO resurrectPlayer    : #{Dice.resurrect_player()}"
    puts "\tCOMPROBACION DEL METODO weaponsReward      : #{Dice.weapons_reward()}"
    puts "\tCOMPROBACION DEL METODO shieldsReward      : #{Dice.shields_reward()}"
    puts "\tCOMPROBACION DEL METODO usesLeft           : #{Dice.uses_left()}"
    puts "\tCOMPROBACION DEL METODO intensity          : #{Dice.intensity(i)}"
    puts "\tCOMPROBACION DEL METODO discardElement     : #{Dice.discard_element(i)}"

    puts "------------------------------------------------"
  end


end