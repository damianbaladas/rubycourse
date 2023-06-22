class Board
    attr_reader :grid
  
    def initialize
      @grid = Array.new(3) { Array.new(3, " ") }
    end
  
    def display
      puts "---------"
      @grid.each do |row|
        puts "| #{row.join(" | ")} |"
        puts "---------"
      end
    end
  
    def place_marker(row, col, marker)
      @grid[row][col] = marker if valid_move?(row, col)
    end
  
    def valid_move?(row, col)
      row.between?(0, 2) && col.between?(0, 2) && @grid[row][col] == " "
    end
  
    def full?
      @grid.all? { |row| row.none?(" ") }
    end
  
    def winner?
      winning_combinations = [
        # Rows
        [grid[0][0], grid[0][1], grid[0][2]],
        [grid[1][0], grid[1][1], grid[1][2]],
        [grid[2][0], grid[2][1], grid[2][2]],
        # Columns
        [grid[0][0], grid[1][0], grid[2][0]],
        [grid[0][1], grid[1][1], grid[2][1]],
        [grid[0][2], grid[1][2], grid[2][2]],
        # Diagonals
        [grid[0][0], grid[1][1], grid[2][2]],
        [grid[0][2], grid[1][1], grid[2][0]]
      ]
  
      winning_combinations.any? do |combination|
        combination.uniq.length == 1 && combination[0] != " "
      end
    end
  end
  
  class Player
    attr_reader :name, :marker
  
    def initialize(name, marker)
      @name = name
      @marker = marker
    end
  
    def make_move
      print "Enter row (0-2): "
      row = gets.chomp.to_i
  
      print "Enter column (0-2): "
      col = gets.chomp.to_i
  
      [row, col]
    end
  end
  
  class Game
    def initialize
      @board = Board.new
      @players = [Player.new("Player 1", "X"), Player.new("Player 2", "O")]
      @current_player = @players[0]
    end
  
    def play
      puts "Welcome to Tic-Tac-Toe!"
  
      loop do
        @board.display
  
        row, col = @current_player.make_move
  
        if @board.valid_move?(row, col)
          @board.place_marker(row, col, @current_player.marker)
  
          if @board.winner?
            @board.display
            puts "#{@current_player.name} wins!"
            break
          elsif @board.full?
            @board.display
            puts "It's a tie!"
            break
          else
            switch_players
          end
        else
          puts "Invalid move! Try again."
        end
      end
  
      puts "Game Over. Thanks for playing!"
    end
  
    private
  
    def switch_players
      @current_player = @current_player == @players[0] ? @players[1] : @players[0]
    end
  end
  
  # Start the game
  Game.new.play
  