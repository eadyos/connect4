require_relative "../src/game"
require "minitest/autorun"

class TC_Game < Minitest::Test

    def test_create
        refute_nil(Game.new)
    end

    def test_new_state_as_text
        game = Game.new
        assert_match(/(\| \| \| \| \| \| \| \|\n){6}/,
            game.state_as_text)
    end
 
    def test_game_not_won
        game = Game.new
        assert_equal(game.is_won?("1"), false)
    end

    def test_game_won_diagnol_up
        game = Game.new
        game.add_token_to_column("1",1)
        game.add_token_to_column("2",2)
        game.add_token_to_column("1",2)
        game.add_token_to_column("2",3)
        game.add_token_to_column("2",3)
        game.add_token_to_column("1",3)
        game.add_token_to_column("2",4)
        game.add_token_to_column("2",4)
        game.add_token_to_column("2",4)
        game.add_token_to_column("1",4)
        assert_equal(game.is_won?("1"), true)
    end
    
    def test_game_won_diagnol_down
        game = Game.new
        game.add_token_to_column("2",1)
        game.add_token_to_column("2",1)
        game.add_token_to_column("2",1)
        game.add_token_to_column("1",1)
        game.add_token_to_column("2",2)
        game.add_token_to_column("2",2)
        game.add_token_to_column("1",2)
        game.add_token_to_column("2",3)
        game.add_token_to_column("1",3)
        game.add_token_to_column("1",4)
        assert_equal(game.is_won?("1"), true)
    end

    def test_game_won_horizontal
        game = Game.new
        game.add_token_to_column("1",1)
        game.add_token_to_column("1",2)
        game.add_token_to_column("1",3)
        game.add_token_to_column("1",4)
        assert_equal(game.is_won?("1"), true)
    end
    
    def test_game_won_vertical
        game = Game.new
        game.add_token_to_column("1",1)
        game.add_token_to_column("1",1)
        game.add_token_to_column("1",1)
        game.add_token_to_column("1",1)
        assert_equal(game.is_won?("1"), true)
    end


end 