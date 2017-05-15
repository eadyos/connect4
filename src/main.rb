require_relative 'game'
require "highline/import"


player1 = "1"
player2 = "2"
players = [player1, player2]
turn = 0

game = Game.new

loop do
    game.show()
    currentPlayer = players[turn % players.size]
    otherPlayer = players[(turn + 1) % players.size]
    if turn % 2 == 1
        game.take_computer_turn(currentPlayer, otherPlayer)
        turn += 1
    else
        column = ask "Player #{currentPlayer}, Select Column: "
        if game.add_token_to_column(currentPlayer, column.to_i)
            turn += 1
        else
            puts "Column is full.  Try again"
        end
    end
    
    break if game.is_draw? || game.is_won?(currentPlayer)
end

game.show()
currentPlayer = players[(turn -1) % players.size]
if game.is_draw?
    puts "The game is a draw"
else
    puts "The game is over.  Player #{currentPlayer} wins!"
end
