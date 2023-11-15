require_relative '../UI/textUI'
require_relative '../Controller/controller'
require_relative '../irrgarten/game'
include UI
include Control
include Irrgarten

module Main
  class Main
    def self.main
      nplayer = 2

      # Crear instancias del juego, la vista y el controlador
      game = Game.new(nplayer)
      text_ui = TextUI.new
      controller = Controller.new(game, text_ui)

      # Iniciar el juego a través del controlador
      controller.play

    end
  end
  Main.main
end