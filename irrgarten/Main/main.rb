require_relative 'irrgarten/ui/text_ui'
require_relative 'irrgarten/controller'
require_relative 'irrgarten/game'

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
end
