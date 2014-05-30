class Blackjack
  attr_reader :player_hand, :dealer_hand, :show_dealer_hand

  def initialize(player_hand = [], dealer_hand = [])
    @player_hand = player_hand
    @dealer_hand = dealer_hand
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
    if score(@dealer_hand) < 17 || score(@dealer_hand) < score(@player_hand)
      @dealer_hand << deck.pop
      deal_dealer(deck)
    end
    @dealer_hand
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
    if score > 21 && ace_count >= 1
      score -= 10
      ace_count -= 1
    end
    score
  end

  def blackjack?(hand)
    handcheck = []
    handcheck << hand[0].chop
    handcheck << hand[1].chop
    if handcheck.include?("A") && (handcheck.include?("K") || handcheck.include?("Q") || handcheck.include?("J"))
      return true
    end
    false
  end

  def bust?()
    score(@player_hand) > 21
  end

  def winner()
    if @player_hand.size == 2 && blackjack?(@player_hand) && !blackjack?(@dealer_hand)
      return 2
    elsif (!bust? && score(@player_hand) > score(@dealer_hand)) || score(@dealer_hand) > 21
      return 1
    elsif bust? || score(@player_hand) < score(@dealer_hand)
      return -1
    else
      return 0
    end
  end
end
