#encoding:utf-8
#frozen_string_literal: true

class Game_state
  @labyrinthv =""
  @players =""
  @monsters =""
  @current_player=0
  @winner=false
  @log=""

  #constructor
  def initialize(laberinto,jugadores,monstruos,indice_jugador,ganador,atributo)
    @labyrinthv=laberinto
    @players=jugadores
    @monsters=monstruos
    @current_player = indice_jugador
    @winner = ganador
    @log = atributo
  end

  def labyrinthv
    @labyrinthv
  end

  def players
    @players
  end

  def monsters
    @monsters
  end

  def current_player
    @current_player
  end

  def winner
    @winner
  end

  def log
    @log
  end

end
