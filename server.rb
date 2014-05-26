require 'sinatra'
require_relative 'blackjack.rb'
require_relative 'deck.rb'
require_relative 'wallet.rb'

get '/' do
  @game = Blackjack.new
  @deck = Deck.new
  @wallet = Wallet.new

  erb :index
end

post '/' do


  erb :index
end
