class Deck
  attr_reader :deck

  def initialize
    @deck = make_deck()
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
    deck
  end

  def shuffle_deck
    @deck.shuffle
  end
end
