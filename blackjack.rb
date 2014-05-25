class Blackjack
  attr_reader :player_hand, :dealer_hand, :show_dealer_hand

  def initialize()
    @player_hand = []
    @dealer_hand = []
  end

  def deal_hands(deck)
    2.times do
      @player_hand << deck.pop
      @dealer_hand << deck.pop
    end
  end

  def show_dealer_hand()
    @show_dealer_hand = @dealer_hand.pop
  end

  def deal_player(deck)
    @player_hand << deck.pop
  end

  def deal_dealer(deck)
    if score(@dealer_hand) < 17
      @dealer_hand << deck.pop
      deal_dealer()
    end
    score(@dealer_hand)
  end

  def score(hand)
    score = 0
    ace_count = 0
    hand.each do |card|
      card = card.chop
      if card == "J" || card == "Q" || card == "K"
        score += 10
      elsif card == "A"
        score += 11
        ace_count += 1
      else
        score += card.to_i
      end
    end
    if score > 21 && ace_count > 1
      score -= 10
      ace_count -= 1
    end
    score
  end

  def bust?()
    score(@player_hand) > 21
  end

  def winner()
    if @player_hand > @dealer_hand
      return 1
    elsif @player_hand < @dealer_hand
      return -1
    else
      return 0
    end
  end
end
