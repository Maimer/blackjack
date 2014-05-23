class Blackjack
  attr_reader :deck, :player_hand, :dealer_hand, :show_dealer_hand

  def initialize()
    @deck = make_deck()
    @player_hand = []
    @dealer_hand = []
  end

  def make_deck()
    suits = ["S", "H", "D", "C"]
    values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    deck = []

    values.each do |value|
      suits.each do |suit|
        deck << value + suit
      end
    end
    deck.shuffle!
  end

  def deal_hands()
    2.times do
      @player_hand << @deck.pop
      @dealer_hand << @deck.pop
    end
  end

  def show_dealer_hand()
    @show_dealer_hand = @dealer_hand.pop
  end

  def deal_player()
    @player_hand << @deck.pop
  end

  def deal_dealer()
    if score(@dealer_hand) < 17
      @dealer_hand << @deck.pop
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
end

a = Blackjack.new

a.deal_hands

puts a.player_hand.inspect
puts a.dealer_hand.inspect
puts a.show_dealer_hand.inspect

puts a.score(a.player_hand)
puts a.deal_dealer
puts a.dealer_hand.inspect

