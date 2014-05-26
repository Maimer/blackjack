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
    if line[id] == id
      game = JSON.parse(line, symbolize_names: true)
    end
  end
  game
end

def save_game(id, game, deck, wallet)
  redis = get_connection
  list_of_games = redis.lrange("blackjack:games", 0, -1)

  list_of_games.each do |line|
    if line[id] == id
      redis.hdel(line, "id")
      redis.hdel(line, "game")
      redis.hdel(line, "deck")
      redis.hdel(line, "wallet")
      redis.hdel(line, "created")
    end
  end

  game = { id: id, game: game, deck: deck, wallet: wallet, created: Time.now }

  redis.lpush("blackjack:games", game.to_json)
end
