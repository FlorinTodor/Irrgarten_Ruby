#encoding:utf-8
# frozen_string_literal: true
require_relative 'monster'
require_relative 'player'
require_relative 'orientation'
require_relative 'dice'
require_relative 'directions'
module Irrgarten
class Labyrinth

  #Atributos privados

  @@BLOCK_CHAR = 'X'
  @@EMPTY_CHAR = '-'
  @@MONSTER_CHAR = 'M'
  @@COMBAT_CHAR = 'C'
  @@EXIT_CHAR = 'E'
  @@ROW = 0
  @@COL = 1

  #Metodos
  #Constructor
  def initialize (nrows, ncols, exitrow, exitcol)
    @nrows = nrows
    @ncols = ncols
    @exitrow = exitrow
    @exitcol = exitcol
    #En este caso, se pone ' ' porque tiene un miembro char llamado content
    @labyrinth = Array.new(nrows){Array.new(ncols){@@EMPTY_CHAR}}
    @monsters = Array.new(nrows){Array.new(ncols){nil}}
    @players = Array.new(nrows) {Array.new(ncols){nil}}
  end

  #Metodos getters y setters para nrows, ncols, exitrow, exit
  def get_nrows
    @nrows
  end

  def set_nrows(nrows)
    @nrows = nrows
  end

  def get_ncols
    @ncols
  end

  def set_ncols(ncols)
    @ncols = ncols
  end

  def get_exitrow
    @exitrow
  end

  def set_exitrow(exitrow)
    @exitrow = exitrow
  end

  def get_exitcol
    @exitcol
  end

  def set_exitcol(exitcol)
    @exitcol = exitcol
  end

  #Metodos Class Labyrinth
  def spread_players(players)
    for i in (0...players.length)
      p = players[i]
      pos = random_empty_pos
      put_player_2d(-1, -1, pos[@@ROW], pos[@@COL], p)
    end
  end

  #boolean haveAWinner()
  def have_a_winner
    @players[@exitrow][@exitcol] != nil
  end

  #String toString()
  def to_s
    laberinto = ""

    for i in (0...@nrows)
      for j in (0...@ncols)
        if i == @exitrow && j == @exitcol
          laberinto += @@EXIT_CHAR + " "
        else
          laberinto += @labyrinth[i][j] + " "
        end
      end
      laberinto += "\n"
    end

    laberinto
  end

  #addMonster(int row, int col, Monster monster)
  def add_monster(row, col, monster)
    #Verifica si la posición está dentro del laberinto y está vacía
    if pos_ok(row,col) && empty_pos(row,col)

      #Anota la presencia del monstruo en el laberinto
      @labyrinth[row][col] = @@MONSTER_CHAR

      #Guarda la referencia del monstruo en el atributo adecuado
      @monsters[row][col] = monster

      #Indica al monstruo cual es su posicion actual
      monster.set_pos(row,col)
    end
  end

  #putPlayer(direction : Directions, player : Player) : Monster
  def put_player(direction, player)
    old_row = player.get_row
    old_col = player.get_col

    new_pos = dir_2_pos(old_row, old_col, direction)

    monster = put_player_2d(old_row, old_col, new_pos[@@ROW], new_pos[@@COL], player)

    monster
  end

  #addBlock(orientation : Orientation, startRow : int, startCol : int, length : int) : void
  def add_block(orientation, start_row, start_col, length)
    if orientation == Orientation::VERTICAL
      inc_row = 1
      inc_col = 0
    else
      inc_row = 0
      inc_col = 1
    end

    row = start_row
    col = start_col

    while pos_ok(row,col) && empty_pos(row,col) && length > 0
      @labyrinth[row][col] = @@BLOCK_CHAR

      length -= 1
      row += inc_row
      col += inc_col
    end
  end

  #validMoves(row : int, col : int) : Directions[]
  def valid_moves(row, col)
    output = Array.new

    if can_step_on(row+1,col)
      output.push(Directions::DOWN)
    end

    if can_step_on(row-1,col)
      output.push(Directions::UP)
    end

    if can_step_on(row,col+1)
      output.push(Directions::RIGHT)
    end

    if can_step_on(row,col-1)
      output.push(Directions::LEFT)
    end

    return output
  end

  private
  #posOK(row : int, col : int) : boolean
  def pos_ok(row,col)
    row >= 0 && row < @nrows && col >= 0 && col < @ncols
  end

  #emptyPos(row : int, col : int) : boolean
  def empty_pos(row, col)
    #Primero comprobamos si es una posición dentro del laberinto
    if pos_ok(row,col)
      return (@labyrinth[row][col] == @@EMPTY_CHAR && @players[row][col] == nil && @monsters[row][col] == nil)
    end

    #Si no se considera ni posicion del laberinto return false
    return false
  end

  #monsterPos(row : int, col : int) : boolean
  def monster_pos(row,col)
    if pos_ok(row,col)
      #Comprobamos que unicamente se encuentra un monster
      return (@players[row][col] == nil && @monsters[row][col] != nil)
    end

    return false
  end

  #exitPos(row : int, col : int) : boolean
  def exit_pos(row,col)
    if pos_ok(row,col)
      return (row == @exitrow && col == @exitcol)
    end

    return false
  end

  #combatPos(row : int, col : int) : boolean
  def combat_pos(row,col)
    if pos_ok(row,col)
      #Comprobamos que unicamente se encuentra un monster
       (@labyrinth[row][col] == @@COMBAT_CHAR && @players[row][col] != nil && @monsters[row][col] != nil)
    else
      false
    end
  end

  #canStepOn(row : int, col : int) : boolean
  def can_step_on(row,col)
    #Comprobamos que primero sea una posicion valida y que al menos sea una de las 3 opciones
    return (pos_ok(row,col) && empty_pos(row,col) || monster_pos(row,col) || exit_pos(row,col))
  end

  #updateOldPos(row : int, col : int) : void
  def update_old_pos(row,col)
    if pos_ok(row,col)
      if combat_pos(row,col)
        #Si el estado de la casilla era de combate, cambia a estado de monstruo
        @labyrinth[row][col] = @@MONSTER_CHAR
      else
        #En otro caso, cambia a estado de casilla vacia
        @labyrinth[row][col] = @@EMPTY_CHAR
      end
    end
  end

  #dir2Pos(row : int, col : int, direction : Directions) : int[]
  def dir_2_pos(row,col,direction)
    new_row = row
    new_col = col

    case direction
    when Directions::UP
      new_row -= 1
    when Directions::DOWN
      new_row += 1
    when Directions::LEFT
      new_col -= 1
    when Directions::RIGHT
      new_col += 1
    end


    #Creamos un array de int que contenga el valor de nueva columna y el valor de nueva fila
    new_position = Array.new(new_row,new_col)

    return new_position
  end

  #randomEmptyPos() : int[]
  def random_empty_pos()
    position = [0,0]
    max_intentos = @nrows * @ncols

    for i in (0...max_intentos)
      random_row = Dice.random_pos(@nrows) #Genera fila aleatoria
      random_col = Dice.random_pos(@ncols) #Genera columna aleatoria

      #Comprobamos que sea una posicion vacia
      if empty_pos(random_row, random_col) && random_row != @exitrow && random_col != @exitcol
        position[0] = random_row
        position[1] = random_col
        return position #Devuelve la posición vacía
      end
    end

    #Si no se encuentra una posición vacía después de un número máximo de intentos, retorna null
    return nil
  end

  #putPlayer2D(oldRow : int, oldCol : int, row : int, col : int, player : Player) : Monster
  def put_player_2d(old_row,old_col,row,col,player)
    output = nil

    if can_step_on(row,col)
      if pos_ok(old_row,old_col)
        p = @players[old_row][old_col]

        if p == player
          update_old_pos(old_row,old_col)
          @players[old_row][old_col] = nil
        end
      end

      monster_pos = monster_pos(row,col)

      if monster_pos
        @labyrinth[row][col] = @@COMBAT_CHAR
        output = @monsters[row][col]
      else
        @labyrinth[row][col] = player.get_number
      end

      @players[row][col] = player
      player.set_pos(row,col)
    end

    return output
  end
end
end