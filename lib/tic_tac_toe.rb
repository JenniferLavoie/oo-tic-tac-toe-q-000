class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  #def board=(board)
    #@board = board
  #end

  #def board
   # @board
  #end

  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def move(location, current_player = "X")
    @board[location.to_i-1] = current_player
  end

  def position_taken?(location)
    !(@board[location].nil? || @board[location] == " ")
  end

  def valid_move?(position)
    position.to_i.between?(1,9) && !position_taken?(position.to_i-1)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    if valid_move?(input)
      move(input, current_player)
    else
      turn
    end
      display_board
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]] &&
      position_taken?(combo[0])
    end
  end

  def full?
    @board.all?{|token| token == "X" || token == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || full?
  end

  def winner
    if winning_combo = won?
      @board[winning_combo.first]
    end
  end

  def play
  
    while !over?
      turn
      if draw?
        return false
      end
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw? 
      puts "Cats Game!"
      
    end
  end
end