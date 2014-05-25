require 'sinatra'
require_relative 'blackjack.rb'
require_relative 'deck.rb'
require_relative 'wallet.rb'

get '/' do
  @newgame = Blackjack.new
  @newdeck = Deck.new
  @newwallet = Wallet.new


  erb :index
end

