class Deck
  attr_reader :deck

  def initialize
    @deck = make_deck(number)
  end

  def make_deck(number = 1)
    suits = ["S", "H", "D", "C"]
    values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    deck = []

    number.times do
      values.each do |value|
        suits.each do |suit|
          deck << value + suit
        end
      end
    end
    deck.shuffle
  end
end
