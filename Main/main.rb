require_relative '../UI/textUI'
require_relative '../Controller/controller'
require_relative '../irrgarten/game'
require_relative '../irrgarten/directions'
include UI
include Control
include Irrgarten

  class Main
    def self.main
      nplayer = 2

      # Crear instancias del juego, la vista y el controlador
      game = Irrgarten::Game.new(nplayer)
      text_ui = UI::TextUI.new
      #text_ui.show_game(game.get_game_state)
      controller = Control::Controller.new(game, text_ui)

      # Iniciar el juego a través del controlador
      controller.play

    end
  end
  Main.main
