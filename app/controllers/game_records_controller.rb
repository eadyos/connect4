
class GameRecordsController < ApplicationController
  before_action :set_game_record, only: [:update]

  def index
  end

  def create
    game = Game.new
    @game_record = GameRecord.create(json_state: game.state_as_json)
    puts "here it is"
    puts @game_record.json_state
    data = {'id' => @game_record.id, 'state' => game.state_as_json}
    render json: data, :layout => false
  end

  def update
    result = ""
    game = Game.new(@game_record.json_state)
    game.add_token_to_column("1", params[:column])
    if game.is_draw?
      result = "draw"
    elsif game.is_won?("1")
      result = "won"
    end
    if result == ""
      game.take_computer_turn("2", "1")
      if game.is_draw?
        result = "draw"
      elsif game.is_won?("2")
        result = "lost"
      end
    end
    @game_record.json_state = game.state_as_json()
    @game_record.save()
    data = {'state' => game.state_as_json, 'result' => result}
    render json: data, :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_record
      @game_record = GameRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_record_params
      params.require(:game_record).permit(:json_state)
    end
end
