#encoding:utf-8

# Ejemplo de programa específico para probar una situación concreta

# Este programa prueba la situación en que un jugador intenta atravesar un muro o salirse del espacio del laberinto

# Primero hay que modificar el método  spread_players  de la clase  Labyrinth para que situe a los jugadores justo entre un muro y el exterior, no aleatoriamente
# En mi caso, lo tengo que poner en la casilla [4][2], tiene un muro a la izquierda y el exterior a la derecha

# ACUÉRDATE de dejar  spread_players  con su implementación original cuando termines las pruebas

require_relative 'directions'
require_relative 'dice'
require_relative 'game'
require_relative 'game_state'
require_relative 'game_character'
require_relative 'labyrinth'
require_relative 'monster'
require_relative 'orientation'
require_relative 'player'
require_relative 'shield'
require_relative 'weapon'

module Irrgarten
  class PruebaMuro
    def self.show_game (game_state)
      # Aquí puedes copiar y pegar la implementación que has hecho del método  show_game  de la clase  TextUI
    end

    def self.main
      g = Game.new(1); # Para la prueba solo necesitamos un jugador
      show_game (g.game_state()) # Mostramos toda la información
      g.next_step (Directions::LEFT) # Intentamos mover al jugador un paso a la izquierda, donde tiene el muro
      show_game (g.game_state()) # Volvemos a mostrar toda la información y comprobamos que ha funcionado bien, no ha atravesado el muro
      g.next_step (Directions::RIGHT) # Intentamos mover al jugador un paso a la derecha, donde ya no hay laberinto
      show_game (g.game_state()) # Volvemos a mostrar toda la información y comprobamos que ha vuelto a funcionar bien
    end

  end
end

Irrgarten::PruebaMuro.main
