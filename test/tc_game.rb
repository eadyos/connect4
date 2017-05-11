require_relative "../src/game"
require "test/unit"

class TC_Game < Test::Unit::TestCase

    def test_create
        assert_not_nil(Game.new)
    end

    def test_show
        game = Game.new
        assert_match(game.show, /(\| \| \| \| \| \| \| \|\n){6}/)
    end

end