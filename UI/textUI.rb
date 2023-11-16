require_relative '../irrgarten/labyrinth'
require_relative '../irrgarten/game'
require_relative '../irrgarten/game_state'
require_relative '../irrgarten/directions'
require_relative '../irrgarten/player'
require_relative '../irrgarten/monster'
require   'io/console'

module UI

  class TextUI

    #https://gist.github.com/acook/4190379
    def read_char
      STDIN.echo = false
      STDIN.raw!
    
      input = STDIN.getc.chr
      if input == "\e" 
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!
    
      return input
    end

    def next_move
      print "Where? "
      got_input = false
      while (!got_input)
        c = read_char
        case c
          when "w"
            puts "UP ARROW"
            output = Irrgarten::Directions::UP
            got_input = true
          when "s"
            puts "DOWN ARROW"
            output = Irrgarten::Directions::DOWN
            got_input = true
          when "d"
            puts "RIGHT ARROW"
            output = Irrgarten::Directions::RIGHT
            got_input = true
          when "a"
            puts "LEFT ARROW"
            output = Irrgarten::Directions::LEFT
            got_input = true
          when "\u0003"
            puts "CONTROL-C"
            got_input = true
            exit(1)
          else
            #Error
        end
      end
      output
    end

    def show_game(game_state)
      # Mostrar información del laberinto
      puts "Laberinto:"
      puts game_state.labyrinth

      # Mostrar información de los jugadores
      puts "\nJugadores:"
      puts game_state.players

      # Mostrar información de los monstruos
      puts "\nMonstruos:"
      puts game_state.monsters

      # Mostrar información del jugador actual
      puts "\nTurno del Jugador: #{game_state.current_player}"

      # Mostrar el registro (log) del juego
      puts "\nRegistro del Juego:"
      puts game_state.log

      # Mostrar si hay un ganador
      puts "¡Felicidades! ¡Has ganado!" if game_state.winner
    end
  end # class   

end # module   


