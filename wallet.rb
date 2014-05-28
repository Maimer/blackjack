class Wallet
  attr_reader :balance

  def initialize(balance = 1000)
    @balance = balance
  end

  def make_bet(bet)
    @balance -= bet
  end

  def update_balance(winner, bet)
    if winner == 2
      @balance += (bet * 2 + bet / 2)
    elsif winner == 1
      @balance += bet * 2
    elsif winner == 0
      @balance += bet
    end
  end
end
