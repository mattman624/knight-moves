
def knight_moves(origin, destination, record = [])
  board = Board.new
  knight = Knight.new(origin)
  queue = []
  record = []  
  current_location = origin
  board.set_piece(current_location)
  still_searching = true
  while current_location != destination && still_searching
    
    record << current_location
    
    queue += add_to_queue(queue, knight, board)
    puts "destination: #{destination}, current location: #{current_location}"
    if queue.include? destination
      knight.move(destination)
      record << destination
    else     
      knight.move(queue[0])
      queue = queue[1..-1]
    end
    current_location = knight.location
   
    board.set_piece(current_location)
  
    if queue.size == 0
      still_searching == false
    end
  end  

  puts "You made it in #{record.size} moves! Path:"
  record.each do |location|
    puts "[#{location.join(", ")}]"
  end
end

def add_to_queue(queue, knight, board)
  possible_adds = knight.possible_moves(board)
  #puts possible_adds.join(", ")
  puts "possible moves: #{possible_adds}"
  adds = []
  puts "#{possible_adds.join(", ")}"
  possible_adds.each do |add|
    adds << add unless queue.include? add
  end
  
  adds
end

class Knight
  attr_accessor :location

  def initialize(location)
    @location = location
  end

  def move(location)
    @location = location
  end

  def possible_moves(board)
    row    = @location[0]
    column = @location[1]
    possible_moves = []
    translation = [[2, 1], [-2, 1], [2, -1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    #row +/-2 column +/- 1, row +/-1, column +/-2
    translation.each do |shift|
      new_coords = [ row + shift[0], column + shift[1] ]
      if board.on_board?(new_coords) && board.get_space(new_coords) != "X"
        
        possible_moves << new_coords
      end 
    end
    possible_moves
  end
end

class Board
  attr_accessor :spaces, :side_size
  
  def initialize(side_size = 8)
    @side_size = side_size
    @spaces = Array.new(@side_size) { Array.new(@side_size) { " " } }
  end 

  def get_space( location )
    @spaces[location[0]][location[1]]
  end

  def set_piece( location )
    x = location[0]
    y = location[1]
    @spaces[x][y] = "X" if @spaces[x][y] == " "
  end

  def on_board?(coords)
    if coords[0] > side_size || coords[1] > side_size || coords[0] < 0 || coords[1] < 0
      false      
    else
      true      
    end
  end
end





