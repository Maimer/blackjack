require 'sinatra'
require_relative 'blackjack.rb'
require_relative 'deck.rb'
require_relative 'wallet.rb'
require_relative 'helpers.rb'
require 'pry'

get '/' do

  get_connection.flushdb

  @game = Blackjack.new
  @deck = Deck.new
  @wallet = Wallet.new
  @wallet.make_bet(100)
  @id = rand(36**6).to_s(36)
  @game.deal_hands(@deck.shuffle_deck)
  save_game(@id, [@game.player_hand, @game.dealer_hand], @deck.deck, @wallet.balance)

  erb :index
end

post '/' do
  @hit = params["hit"]
  @stand = params["stand"]

  if params["hit"] != nil
    @id = params["hit"]
    @action = "hit"
  elsif
    @id = params["stand"]
    @action = "stand"
  elsif
    @id = params["next_hand"]
    @action = "next hand"
  end

  @savedgame = find_game(@id)

  @game = Blackjack.new(@savedgame[:game][0], @savedgame[:game][1])

  if @savedgame[:deck].size < 12
    @deck = Deck.new.shuffle_deck
  else
    @deck = Deck.new(@savedgame[:deck])
  end

  @wallet = Wallet.new(@savedgame[:wallet])

  if @action == "hit"
    @game.deal_player(@deck.deck)
  elsif @action == "stand"
    @game.deal_dealer(@deck.deck)
  elsif @action == "next hand"
    @wallet.update_balance(@game.winner(), 100)
    @game = Blackjack.new
    @deck = Deck.new
    @wallet.make_bet(100)
    @game.deal_hands(@deck.shuffle_deck)
  end

  save_game(@id, [@game.player_hand, @game.dealer_hand], @deck.deck, @wallet.balance)

  erb :index
end
