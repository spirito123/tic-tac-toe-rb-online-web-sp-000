# define WIN_COMBINATION constant 
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

#display_board method
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index method
def input_to_index(user_input)
    user_input.to_i - 1
end

#move method
def move(board, index, player_token)
    board[index] = player_token
end

#position_taken method
def position_taken?(board, index)
    if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
        return false 
    else
       return true
    end
end 

#valid_move method
def valid_move?(board, index)
    if index.between?(0,8) && !position_taken?(board, index)
        return true
    end
end


#turn_count method
def turn_count(board)
    counter = 0
    board.each do |spaces|
       if spaces == "X" || spaces == "O"
          counter += 1
       end
    end
    counter
end

#current_player
def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end


# #turn method
def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.chomp
    index = input_to_index(user_input)
    if valid_move?(board, index) && !position_taken?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

#won? 
def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
  
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    return false
end

#full? 
def full?(board)
    board.all? {|i| i == "X" || i == "O"}
end

#draw?
def draw?(board)
    !won?(board) && full?(board)
end

#over?
def over?(board)
    won?(board) || draw?(board)
end

#winner method
def winner(board)
    if won?(board)
      return board[won?(board)[0]]
    end
end

#play method
def play(board)
    until over?(board) 
        turn(board)
    end

    if won?(board)
        winner = winner(board)
        puts "Congratulations #{winner}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end
