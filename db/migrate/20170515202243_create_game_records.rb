class CreateGameRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :game_records do |t|
      t.string :json_state

      t.timestamps
    end
  end
end
