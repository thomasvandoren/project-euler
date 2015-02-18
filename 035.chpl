/*
 * Circular primes
 */

use MathFunctions;

config const maxNum: uint = 1000000;
config param debug = false;

proc main() {
  var circularPrimes: domain(uint);
  for p in primesUpTo(maxNum) {
    if isCircular(p) {
      circularPrimes += p;
      if debug then
        writeln(p);
    }
  }
  writeln(circularPrimes.size);
}

// Returns if true if `p` and all its variations of digits are prime.
proc isCircular(p) {
  if p < 10 then
    return true;

  var n = rotateOne(p);
  while n != p {
    if !isPrime(n) then
      return false;
    n = rotateOne(n);
  }

  return true;
}

// Rotate `n` one digit to the right and return.
inline proc rotateOne(n: uint): uint {
  return ((n % 10): string + (n / 10):string): uint;
}
