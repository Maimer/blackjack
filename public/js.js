function validateInitialBet() {
  if (document.homepage_form.initial_bet.value > 0 &&
    document.homepage_form.initial_bet.value < 1001 ) {
    return true;
  } else {
    document.getElementById("homepage_initial_bet").innerHTML = "*Must be between 0 and 1000";
    return false;
  }
}
