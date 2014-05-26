require 'sinatra'
require_relative 'blackjack.rb'
require_relative 'deck.rb'
require_relative 'wallet.rb'
require 'pry'

get '/' do
  @game = Blackjack.new
  @deck = Deck.new
  @wallet = Wallet.new

  @game.deal_hands(@deck.deck)

  erb :index
end

post '/' do
  @action = params["action"]

  erb :index
end
