require 'json'
require 'redis'

def get_connection
  if ENV.has_key?("REDISCLOUD_URL")
    Redis.new(url: ENV["REDISCLOUD_URL"])
  else
    Redis.new
  end
end

def find_game(id)
  redis = get_connection
  list_of_games = redis.lrange("blackjack:games", 0, -1)

  game = {}

  list_of_games.each do |line|
    binding.pry
    if line[id] == id
      game = JSON.parse(line, symbolize_names: true)
    end
  end
  game
end

def save_game(id, game, deck, wallet)
  game = { id: id, game: game, deck: deck, wallet: wallet, created: Time.now }

  redis = get_connection
  redis.lpush("blackjack:games", game.to_json)
end
