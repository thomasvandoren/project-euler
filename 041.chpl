/*
 * Pandigital prime
 */

use MathFunctions;

config const printPrimes = false;

proc main() {

  // This is the largest pandigital number, so the largest pandigital prime
  // must be less than or equal to it.
  //
  // Note that 9 and 8 are left off, because a number with digits 1-8 or digits
  // 1-9 is divisible by 3.
  const maxNum: uint = 7654321;
  var maxPrime: uint;

  for p in primesUpTo(maxNum) {
    if isPandigital(p) {
      maxPrime = p;
      if printPrimes then
        writeln(p, " is pandigital.");
    }
  }
  writeln(maxPrime);
}

// Returns true if p is pandigital. An n-digit number is pandigital if it makes
// use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit
// pandigital and is also prime.
proc isPandigital(p: uint) {
  const D = {1..9};
  var A: [D] bool;

  var length = 0,
    r = p;

  while r > 0 {
    const d = (r % 10): int;

    // If digit `d` has already been seen or is zero, `p` is not pandigital.
    if d == 0 || A[d] then
      return false;

    A[d] = true;
    length += 1;
    r /= 10;
  }

  // writeln("A[1..length] --> ", A[1..length]);
  return (&& reduce A[1..length]) &&
    (&& reduce !A[length+1..]);
}
