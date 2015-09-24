/*
 * Digit factorials
 */

use MathFunctions;

config const debug = false;

proc main() {
  const digitFactorials: [0..9] int = forall d in 0..9 do intFactorial(d);
  proc sumFactorialDigits(d) {
    var sum = 0;
    for i in digits(d) do
      sum += digitFactorials[i];
    return sum;
  }

  var sum: atomic int;
  forall n in 10..10000000 { // arbitrarily large number :-\
    if n == sumFactorialDigits(n) {
      if debug then
        writeln(n, " is curious");
      sum.add(n);
    }
  }
  writeln(sum.read());
}


