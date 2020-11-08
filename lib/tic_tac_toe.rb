class TicTacToe
    attr_accessor :board, :values, :input

    WIN_COMBINATIONS = [
        [0, 1, 2], #top across
        [3, 4, 5], #middle across
        [6, 7, 8], #bottom across 
        [0, 3, 6], #first column
        [1, 4, 7], #middle column
        [2, 5, 8], #last column
        [0, 4, 8], #top to bottom \
        [6, 4, 2] #bottom to top /
    ]

    def initialize(board = nil)
      @board = board || Array.new(9, " ")
      puts "Welcome to Tic Tac Toe"
      display_board
    end
  
    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end
  
    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        @input = input.strip.to_i - 1
    end

    def move(index, player = "X")
        @board[index] = player
    end

    def position_taken?(index)
        @board[index] == " " || @board[index] == nil ? false : true
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn
        puts "Please choose a number 1-9:"
        move = gets.strip
        index = input_to_index(move)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.find do |win_combo|
            @values = @board.values_at(*win_combo)
            @values.all?('X') || values.all?('O')
        end
    end

    def full? 
        @board.all? {|space| space != " "}
    end

    def draw? 
        true if full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        @board[won?[0]] if won?
    end

    def play
        turn until over?
        puts "Congratulations #{winner}!" if won?
        puts "Cat's Game!" if draw?
    end

  end 