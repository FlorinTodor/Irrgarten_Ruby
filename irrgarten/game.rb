#encoding:utf-8
require_relative 'monster'
require_relative 'player'
require_relative 'dice'
require_relative 'labyrinth'
require_relative 'orientation'
require_relative 'directions'
require_relative 'game_character'
require_relative 'game_state'
require_relative 'fuzzy_player'
module Irrgarten
class Game

  #Atributos privados
  @@MAX_ROUNDS = 10

  def initialize(nplayers)
    @players = Array.new

    (0...nplayers).each { |i|
      player = Player.new(i.to_s, Dice.random_intelligence, Dice.random_strength)
      @players.push(player)
    }

    @current_player_index = Dice.random_pos(nplayers)
    @current_player = @players[@current_player_index]
    @monsters = Array.new(5)
    @log = ""
    @labyrinth = Labyrinth.new(9,15,7,15)
    configure_labyrinth
    @labyrinth.spread_players(@players)
  end

  def self.get_max_rounds
    @@MAX_ROUNDS
  end

  def finished
    @labyrinth.have_a_winner
  end

  def next_step(preferred_direction)
    @log = ""
    dead = @current_player.dead

    if !dead
      direction = actual_direction(preferred_direction)

      if direction != preferred_direction
        log_player_no_orders
      end

      monster = @labyrinth.put_player(direction, @current_player)

      if monster == nil
        log_no_monster
      else
        winner = combat(monster)
        manage_reward(winner)
      end
    else
      manage_resurrection
    end

    end_game = finished

    unless end_game
      next_player
    end

    end_game
  end

  def get_game_state
    game = Game_state.new(@labyrinth.to_s, @players, @monsters, @current_player.number.to_s, finished, @log)
    return game
  end

  private
  def configure_labyrinth
    # Configura el laberinto personalizado
    # Nota: Estoy asumiendo que las dimensiones son 8x15
    # Área
    @labyrinth.add_block(Orientation::HORIZONTAL, 0, 0, 15) # Fila 0
    @labyrinth.add_block(Orientation::VERTICAL, 1, 0, 7)   # Columna 0
    @labyrinth.add_block(Orientation::HORIZONTAL, 8, 0, 15)  # Fila 7
    @labyrinth.add_block(Orientation::VERTICAL, 1, 14, 6)   # Columna 15

    # Bloques internos
    @labyrinth.add_block(Orientation::HORIZONTAL, 2, 2, 3)
    @labyrinth.add_block(Orientation::HORIZONTAL, 2, 8, 2)
    @labyrinth.add_block(Orientation::HORIZONTAL, 2, 11, 2)
    @labyrinth.add_block(Orientation::HORIZONTAL, 3, 9, 1)
    @labyrinth.add_block(Orientation::VERTICAL, 3, 12, 2)
    @labyrinth.add_block(Orientation::VERTICAL, 4, 11, 1)
    @labyrinth.add_block(Orientation::VERTICAL, 4, 13, 1)
    @labyrinth.add_block(Orientation::VERTICAL, 4, 5, 1)
    @labyrinth.add_block(Orientation::HORIZONTAL, 4, 1, 3)
    @labyrinth.add_block(Orientation::HORIZONTAL, 5, 3, 1)
    @labyrinth.add_block(Orientation::HORIZONTAL, 6, 2, 2)
    @labyrinth.add_block(Orientation::HORIZONTAL, 6, 5, 5)
    @labyrinth.add_block(Orientation::HORIZONTAL, 6, 11, 3)
    @labyrinth.add_block(Orientation::HORIZONTAL, 7, 7, 1)
    @labyrinth.add_block(Orientation::VERTICAL, 2, 6, 3)
    @labyrinth.add_block(Orientation::HORIZONTAL, 4, 7, 3)

    ogre = Monster.new("Ogre", Dice.random_intelligence, Dice.random_strength)
    vampire = Monster.new("Vampire", Dice.random_intelligence, Dice.random_strength)
    demon = Monster.new("Demon", Dice.random_intelligence, Dice.random_strength)
    dragon = Monster.new("Dragon", Dice.random_intelligence, Dice.random_strength)
    zombie = Monster.new("Zombie", Dice.random_intelligence, Dice.random_strength)

    @monsters << ogre
    @monsters << vampire
    @monsters << demon
    @monsters << dragon
    @monsters << zombie

    @labyrinth.add_monster(3, 2, ogre)
    @labyrinth.add_monster(2, 10, vampire)
    @labyrinth.add_monster(2, 5, demon)
    @labyrinth.add_monster(5, 8, dragon)
    @labyrinth.add_monster(7, 12, zombie)

    @labyrinth.set_exitrow(7)
    @labyrinth.set_exitcol(14)

  end

  def next_player
    total = @players.length

    #Incrementa el indice del jugador actual
    # +1 para asegurarnos que esté el rango
    @current_player_index = (@current_player_index + 1)% total

    #Actualiza el jugador actual
    @current_player = @players[@current_player_index]
  end

  def actual_direction(preferred_direction)
    current_row = @current_player.row
    current_col = @current_player.col

    valid_moves = @labyrinth.valid_moves(current_row,current_col)

    output = @current_player.move(preferred_direction,valid_moves)

    return output
  end

   def combat(monster)
    rounds = 0
    winner = Game_character::PLAYER

    player_attack = @current_player.attack

    lose = monster.defend(player_attack)

    while !lose && rounds < @@MAX_ROUNDS
      winner = Game_character::MONSTER

      monster_attack = monster.attack

      lose = @current_player.defend(monster_attack)

      unless lose # es igual que !lose
        player_attack = @current_player.attack
        winner = Game_character::PLAYER
        lose = monster.defend(player_attack)
      end

      rounds += 1
    end

    log_rounds(rounds, @@MAX_ROUNDS)

    winner
  end

  def manage_reward(winner)
    if winner == Game_character::PLAYER
      @current_player.receive_reward
      log_player_won
    else
      log_monster_won
    end
  end

  def replace_with_fuzzy_player(new_fuzzy_player)
    player_index = @current_player_index
      @players[player_index] = new_fuzzy_player
      @current_player = new_fuzzy_player
      @labyrinth.set_player(@current_player.row, @current_player.col, @current_player)
  end

  def manage_resurrection
    resurrect = Dice.resurrect_player

    if resurrect
      @current_player.resurrect
      fuzzy_player = Fuzzy_player.new(@current_player) # Copia los valores
      replace_with_fuzzy_player(fuzzy_player) # Colocamos en current_player el fuzzy_player
      log_resurrected
    else
      log_player_skip_turn
    end
  end

  def log_player_won
    @log += "El jugador  #{@current_player.number} ha ganado el combate.\n"
  end

  def log_monster_won
    @log += "El monstruo ha ganado el combate.\n"
  end

  def log_resurrected
    @log += "El jugador #{@current_player.number} ha resucitado, pero se comporta como un FuzzyPlayer.\n"
  end

  def log_player_skip_turn
    @log += "El jugador #{@current_player.number} ha perdido el turno por estar muerto.\n"
  end

  def log_player_no_orders
    @log += "El jugador #{@current_player.number} no ha seguido las instrucciones del jugador humano (no fue posible).\n"
  end

  def log_no_monster
    @log += "El jugador #{@current_player.number} se ha movido a una celda vacía o no le ha sido posible moverse.\n"
  end

  def log_rounds(rounds, max)
    @log += "Se han producido #{rounds} de #{max} rondas de combate.\n"
  end
end
end