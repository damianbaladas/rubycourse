class Knight
    attr_reader :position, :moves
  
    def initialize(position)
      @position = position
      @moves = generate_moves
    end
  
    private
  
    def generate_moves
      moves = []
      offsets = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  
      offsets.each do |offset|
        x = position[0] + offset[0]
        y = position[1] + offset[1]
  
        moves << [x, y] if valid_move?(x, y)
      end
  
      moves
    end
  
    def valid_move?(x, y)
      x.between?(0, 7) && y.between?(0, 7)
    end
  end
  
  def knight_moves(start, target)
    return [start] if start == target
  
    queue = [[start]]
    visited = [start]
  
    until queue.empty?
      path = queue.shift
      current_square = path.last
      knight = Knight.new(current_square)
  
      knight.moves.each do |move|
        return path + [move] if move == target
  
        unless visited.include?(move)
          queue << path + [move]
          visited << move
        end
      end
    end
  end
  
  # Example usage:
  start = [0, 0]
  target = [1, 2]
  path = knight_moves(start, target)
  
  puts "Shortest path from #{start} to #{target}:"
  puts "You made it in #{path.size - 1} moves! Here's your path:"
  path.each { |square| puts square.inspect }
  