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
  JSON.parse(redis.get(id), symbolize_names: true)
end

def save_game(id, game, deck, wallet, bet)
  redis = get_connection
  redis.setex(id, 3600, { game: game, deck: deck, wallet: wallet, bet: bet, created: Time.now }.to_json)
end

def check_dup(id)
  redis = get_connection
  if redis.exists(id) == true
    return true
  end
  return false
end
