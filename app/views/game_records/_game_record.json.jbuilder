json.extract! game_record, :id, :json_state, :created_at, :updated_at
json.url game_record_url(game_record, format: :json)
