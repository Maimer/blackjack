require 'json'
require 'redis'

def get_connection
  begin
    if ENV.has_key?("REDISCLOUD_URL")
      connection = Redis.new(url: ENV["REDISCLOUD_URL"])
    else
      connection = Redis.new
    end
  ensure
    connection.quit
  end
end

def find_game(id)
  redis = get_connection
  game = JSON.parse(redis.get(id), symbolize_names: true)
  redis.quit
  return game
end

def save_game(id, game, deck, wallet, bet)
  redis = get_connection
  redis.setex(id, 3600, { game: game, deck: deck, wallet: wallet, bet: bet, created: Time.now }.to_json)
  redis.quit
end

def check_dup(id)
  redis = get_connection
  if redis.exists(id) == true
    redis.quit
    return true
  end
  redis.quit
  return false
end
