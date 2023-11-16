#encoding:utf-8
#frozen_string_literal: true
require_relative 'monster'
require_relative 'player'
require_relative 'labyrinth'
module Irrgarten
class Game_state
  #constructor
  def initialize(laberinto,jugadores,monstruos,indice_jugador,ganador,atributo)
    @labyrinth=laberinto
    @players=jugadores
    @monsters=monstruos
    @current_player = indice_jugador
    @winner = ganador
    @log = atributo
  end

  def labyrinth
    @labyrinth
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
end