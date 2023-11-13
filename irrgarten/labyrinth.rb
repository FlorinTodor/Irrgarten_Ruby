# frozen_string_literal: true

class Labyrinth

  #Atributos privados
  @monsters = Array.new(@nrows) { Array.new(@ncols) }
  #En este caso, se pone ' ' porque tiene un miembro char llamado content
  @labyrinth = Array.new(@nrows) { Array.new(@ncols, ' ')}
  @players = Array.new(@nrows) { Array.new(@ncols)}
  @@block_char = 'X'
  @@empty_char = '-'
  @@monster_char = 'M'
  @@combat_char = 'C'
  @@exit_char = 'E'
  @@row = 0
  @@col = 1
  @nrows = 0
  @ncols = 0
  @exitrow = 0
  @exitcol = 0

  #Metodos
  #Constructor
  def initialize (nrows, ncols, exitrow, exitcol)
    @nrows = nrows
    @ncols = ncols
    @exitrow = exitrow
    @exitcol = exitcol

    #En este caso, se pone ' ' porque tiene un miembro char llamado content
    @labyrinth = Array.new(nrows) { Array.new(ncols, ' ') }
    @monsters = Array.new(nrows) { Array.new(ncols) }
    @players = Array.new(nrows) { Array.new(ncols) }

    for i in (0..nrows) #Parentesis para evitar problemas
      for j in (0..ncols) #Parentesis para evitar problemas
        @labyrinth[i][j] = '-'
        @monsters[i][j] = nil #nil es lo mismo que "null" en Java
        @players[i][j] = nil #nil es lo mismo que "null" en Java
      end
    end
  end

  #Metodos getters y setters para nrows, ncols, exitrow, exit
  def get_nrows()
    return @nrows
  end

  def set_nrows(nrows)
    @nrows = nrows
  end

  def get_ncols()
    return @ncols
  end

  def set_ncols(ncols)
    @ncols = ncols
  end

  def get_exitrow()
    return @exitrow
  end

  def set_exitrow(exitrow)
    @exitrow = exitrow
  end

  def get_exitcol()
    return @exitcol
  end

  def set_exitcol(exitcol)
    @exitcol = exitcol
  end

  #Metodos Class Labyrinth
  #
  def spread_players(players)
    raise NotImplementedError
  end

  #boolean haveAWinner()
  def have_a_winner()
    return @players[@exitrow][@exitcol] != nil
  end

  #String toString()
  def to_s
    result = ''

    for i in (0..@nrows)
      for j in (0..@ncols)
        if @players[i][j]
          result += @players[i][j].to_s
        elsif @monsters[i][j]
          result += @monsters[i][j].to_s
        else
          result += @labyrinth[i][j]
        end
      end
      result += "\n"
    end

    return result
  end

  #addMonster(int row, int col, Monster monster)
  def add_monster(row, col, monster)
    #Verifica si la posición está dentro del laberinto y está vacía
    if(posOK(row,col) && emptyPOS(row,col))

      #Anota la presencia del monstruo en el laberinto
      @labyrinth[row][col] = @@monster_char

      #Guarda la referencia del monstruo en el atributo adecuado
      @monsters[row][col] = monster

      #Indica al monstruo cual es su posicion actual
      monster.set_pos(row,col)
    end
  end

  #putPlayer(direction : Directions, player : Player) : Monster
  def put_player(direction, player)
    raise NotImplementedError
  end

  #addBlock(orientation : Orientation, startRow : int, startCol : int, length : int) : void
  def add_block(orientation, start_row, start_col, length)
    raise NotImplementedError
  end

  #validMoves(row : int, col : int) : Directions[]
  def valid_moves(row, col)
    raise NotImplementedError
  end

  #posOK(row : int, col : int) : boolean
  def pos_ok(row,col)
    return (row >= 0 && row < @nrows && col >= 0 && col < @ncols)
  end

  #emptyPos(row : int, col : int) : boolean
  def empty_pos(row, col)
    #Primero comprobamos si es una posición dentro del laberinto
    if(pos_ok(row,col))
      return (@labyrinth[row][col] == @@empty_char && @players[row][col] == nil && @monsters[row][col] == nil)
    end

    #Si no se considera ni posicion del laberinto return false
    return false
  end

  #monsterPos(row : int, col : int) : boolean
  def monster_pos(row,int)
    if(pos_ok(row,col))
      #Comprobamos que unicamente se encuentra un monster
      return (@labyrinth[row][col] == @@empty_char && @players[row][col] == nil && @monsters[row][col] != nil)
    end

    return false
  end

  #exitPos(row : int, col : int) : boolean
  def exit_pos(row,col)
    if(pos_ok(row,col))
      return (row == @exitrow && col == @exitcol)
    end

    return false
  end

  #combatPos(row : int, col : int) : boolean
  def combat_pos(row,col)
    if(pos_ok(row,col))
      #Comprobamos que unicamente se encuentra un monster
      return (@labyrinth[row][col] == @@combat_char && @players[row][col] != nil && @monsters[row][col] != nil)
    end

    return false
  end

  #canStepOn(row : int, col : int) : boolean
  def can_step_on(row,col)
    #Comprobamos que primero sea una posicion valida y que al menos sea una de las 3 opciones
    return (pos_ok(row,col) && empty_pos(row,col) || monster_pos(row,col) || exit_pos(row,col))
  end

  #updateOldPos(row : int, col : int) : void
  def update_old_pos(row,col)
    if(pos_ok(row,col))
      if(@labyrinth[row][col] == @@combat_char)
        #Si el estado de la casilla era de combate, cambia a estado de monstruo
        @labyrinth[row][col] = @@monster_char
      else
        #En otro caso, cambia a estado de casilla vacia
        @labyrinth[row][col] = @@empty_char
      end
    end
  end

  #dir2Pos(row : int, col : int, direction : Directions) : int[]
  def dir_2_pos(row,col,direction)
    new_row = row
    new_col = col

    case direction
    when UP
      new_row--
      break
    when DOWN
      new_row++
      break
    when LEFT
      new_col--
      break
    when RIGHT
      new_col++
      break
    end

    #Creamos un array de int que contenga el valor de nueva columna y el valor de nueva fila
    new_position = Array.new(new_row,new_col)

    return new_position
  end

  #randomEmptyPos() : int[]
  def random_empty_pos()
    position = [0,0]
    max_intentos = @nrows*@ncols

    for i in (0..max_intentos)
      random_row = Dice.random_pos(@nrows) #Genera fila aleatoria
      random_col = Dice.random_pos(@ncols) #Genera columna aleatoria

      #Comprobamos que sea una posicion vacia
      if(empty_pos(random_row, random_col))
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
    raise NotImplementedError
  end



end
