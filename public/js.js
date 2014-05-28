function validateInitialBet() {
  if (document.homepage_form.initial_bet.value > 0 &&
    document.homepage_form.initial_bet.value < 1001 ) {
    return true;
  } else {
    document.getElementById("homepage_initial_bet").innerHTML = "*Must be between 0 and 1000";
    return false;
  }
}

function validateBet() {
  var balance = document.getElementById("wallet_balance").;
  var betValue = document.new_bet.bet.value;
  if (betValue > 0 && betValue <= balance) {
    document.getElementById("new_bet_warning").innderHTML = "";
    return true;
  } else {
    document.getElementById("new_bet_warning").innerHTML = "*Must be between 0 and " + balance;
    return false;
  }
}
