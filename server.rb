require 'sinatra'
require_relative 'blackjack.rb'
require_relative 'deck.rb'
require_relative 'wallet.rb'
require_relative 'helpers.rb'
require 'pry'

get '/' do
  @game = Blackjack.new
  @deck = Deck.new
  @wallet = Wallet.new
  @id = rand(36**6).to_s(36)
  @game.deal_hands(@deck.deck)

  save_game(@id, [@game.player_hand, @game.dealer_hand], @deck.deck, @wallet.balance)

  erb :index
end

post '/' do
  @hit = params["hit"]
  @stand = params["stand"]

  if params["hit"] != nil
    @action = params["hit"]
  else
    @action = params["stand"]
  end

  @savedgame = find_game(@action)

  binding.pry

  get_connection.flushdb

  erb :index
end
