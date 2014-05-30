require 'sinatra'
require_relative 'blackjack.rb'
require_relative 'deck.rb'
require_relative 'wallet.rb'
require_relative 'helpers.rb'

get '/' do

  erb :home
end

post '/' do
  if params["initial_bet"].to_i > 0 && params["initial_bet"].to_i <= 1000
    @game = Blackjack.new
    @deck = Deck.new
    @wallet = Wallet.new
    @bet = params["initial_bet"].to_i
    @wallet.make_bet(@bet)
    @id = rand(36**6).to_s(36)
    while find_game(@id)
      @id = rand(36**6).to_s(36)
    end
    @game.deal_hands(@deck.shuffle_deck)
    if @game.blackjack?(@game.player_hand) && !@game.blackjack?(@game.dealer_hand)
      @action = "blackjack"
    elsif @game.blackjack?(@game.player_hand) && @game.blackjack?(@game.dealer_hand)
      @action = "stand"
    end
    save_game(@id, [@game.player_hand, @game.dealer_hand], @deck.deck, @wallet.balance, @bet)

    erb :index
  elsif params["initial_bet"] == nil
    if params["hit"] != nil
      @id = params["hit"]
      @action = "hit"
    elsif params["stand"] != nil
      @id = params["stand"]
      @action = "stand"
    elsif params["next_hand"] != nil
      @id = params["next_hand"]
      @action = "next hand"
    elsif params["double_down"] != nil
      @id = params["double_down"]
      @action = "double_down"
    end

    @savedgame = find_game(@id)
    @game = Blackjack.new(@savedgame[:game][0], @savedgame[:game][1])
    if @savedgame[:deck].size < 12
      @deck = Deck.new.shuffle_deck
    else
      @deck = Deck.new(@savedgame[:deck])
    end
    @wallet = Wallet.new(@savedgame[:wallet])
    @bet = @savedgame[:bet]

    if @action == "double_down"
      @wallet.make_bet(@bet)
      @bet *= 2
      @game.deal_player(@deck.deck)
      @action = "stand"
    end

    if @action == "hit" && @game.score(@game.player_hand) <= 21
      @game.deal_player(@deck.deck)
    elsif @action == "stand" && @game.score(@game.player_hand) <= 21
      @game.deal_dealer(@deck.deck)
    elsif @action == "next hand"
      @wallet.update_balance(@game.winner(), @bet)
        if params["bet"].to_i > 0 && params["bet"].to_i <= @wallet.balance
          @bet = params["bet"].to_i
        elsif @wallet.balance <= 100
          @bet = @wallet.balance
        else
          @bet = 100
        end
      if @wallet.balance <= 0
        redirect '/'
      end
      @game = Blackjack.new
      @deck = Deck.new
      @wallet.make_bet(@bet)
      @game.deal_hands(@deck.shuffle_deck)
      if @game.blackjack?(@game.player_hand) && !@game.blackjack?(@game.dealer_hand)
        @action = "blackjack"
      elsif @game.blackjack?(@game.player_hand) && @game.blackjack?(@game.dealer_hand)
        @action = "stand"
      end
    end

    save_game(@id, [@game.player_hand, @game.dealer_hand], @deck.deck, @wallet.balance, @bet)

    erb :index
  else
    redirect '/'
  end
end
