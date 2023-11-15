#encoding:utf-8
class Game

  #Atributos privados
  @@max_rounds = 10

  def initialize(nplayers)
    @monsters = Array.new
    @players = Array.new
    @current_rounds = 0

    for i in(0..nplayers)
      @players.push(Player.new(i.to_s, Dice.random_intelligence, Dice.random_strength))
    end
    @current_player_index = Dice.random_pos(nplayers)
    @current_player = @players[@current_player_index]
    @monsters = nil
    @log = ""
    @labyrinth = Labyrinth.new(10,20,5,5)
    configure_labyrinth()
    @labyrinth.spread_players(nplayers)
  end

  def game(nplayers)


  end

  def get_max_rounds()
    return @@max_rounds
  end

  def finished()
    return @labyrinth.have_a_winner
  end

  def next_stepp(preferred_direction)
    return NotImplementedError
  end

  def get_game_state()
    game = GameState.new(@labyrinth.to_s, @players.to_s, @monsters.to_s, @current_player.get_number(), finished, @log)
    return game
  end

  def configure_labyrinth
    laberinto = [
      ['-', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'M', 'X', 'M', 'X', 'X', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'M', 'X', 'X', 'X', 'X', 'M', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'X', 'M', 'E', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'M', 'X', 'X', 'X', 'M', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'X', 'M', 'X', 'X', 'M', 'X', 'X', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'M', 'X', 'X', 'X', 'X', 'M', 'X', 'M', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
      ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
    ]

    #Configura el laberinto
    for i in (0..@labyrinth.get_nrows)
      for j in (0..@labyrinth.get_ncols)
        if(laberinto[i][j] == 'M')
          @labyrinth.add_monster(row,col, Monster.new("Monstruo", Dice.random_intelligence, Dice.random_strength))
        elsif(laberinto[i][j] == 'E')
          @labyrinth.set_exitrow(i)
          @labyrinth.set_exitcol(j)
        elsif(laberinto[i][j] == 'X')
          orientation = Dice.random_pos(2)
          if(orientation == 0)
            @labyrinth.add_block(orientation.HORIZONTAL, i,j,1)
          else
            @labyrinth.add_block(orientation.VERTICAL,i,j,1)
          end

        end
      end
    end
  end

  def next_player()
    total = @players.length

    #Incrementa el indice del jugador actual
    # +1 para asegurarnos que esté el rango
    @current_player_index = (@current_player_index + 1)% total

    #Actualiza el jugador actual
    @current_player = @players[@current_player_index]
  end

  def actual_direction()
    return NotImplementedError
  end

  def combat(monster)
    return NotImplementedError
  end

  def manage_reward(winner)
    return NotImplementedError
  end

  def manage_resurrection()
    return NotImplementedError
  end

  def log_player_won()
    log += "El jugador " + @current_player.get_number + " ha ganado el combate.\n"
  end

  def log_monster_won()
    log += "El monstruo ha ganado el combate.\n"
  end

  def log_resurrected()
    log += "El jugador " + @current_player.get_number + " ha resucitado.\n"
  end

  def log_player_skip_turn()
    log += "El jugador " + @current_player.get_number + " ha perdido el turno por estar muerto.\n"
  end

  def log_player_no_orders()
    log += "El jugador " + @current_player.get_number + " no ha seguido las instrucciones del jugador humano " +
      "(no fue posible).\n";
  end

  def log_no_monster()
    log += "El jugador " + @current_player.get_number + " se ha movido a una celda vacía o no le ha sido " +
      "posible moverse.\n";
  end

  def log_rounds(rounds, max)
    log += "Se han producido " + rounds + " de " + max + " rondas de combate.\n"
  end


end

