/*
 * Truncatable primes
 */

use MathFunctions;

/* When true, print the truncatable primes. */
config const printPrimes = false;

proc main() {
  var count = 0,
    sum: uint = 0;
  for p in primesUpTo(max(uint)) {
    if isTruncatable(p) {
      if printPrimes then
        writeln(p, " is truncatable.");
      sum += p;
      count += 1;
    }
    if count == 11 then
      break;
  }
  writeln(sum);
}

// Assumes `p` is prime.
proc isTruncatable(p: uint) {
  // 2, 3, 5, and 7 are not considered to be truncatable primes.
  if p < 10 then
    return false;

  /* var ltor, rtol: bool; */
  /* cobegin { */
  /*   ltor = isTruncLtoR(p); */
  /*   rtol = isTruncRtoL(p); */
  /* } */
  /* return rtol && ltor; */

  return isTruncRtoL(p) && isTruncLtoR(p);
}

// Removes first digit from `k`. Returns 2..n digits for for number `k` with
// 1..n digits.
proc removeFirst(k: uint) {
  const s = k: string,
    d = s.substring(2..s.length);
  if d.length == 0 then
    return 0: uint;
  return d: uint;
}

// Check if p is truncatable, working from left to right.
proc isTruncLtoR(p: uint) {
  var d = removeFirst(p);
  while d > 0 {
    if !isPrime(d) then
      return false;
    d = removeFirst(d);
  }
  return true;
}


// Check if p is truncatable, working from right to left.
proc isTruncRtoL(p: uint) {
  var d = p / 10;
  while d > 0 {
    if !isPrime(d) then
      return false;
    d /= 10;
  }
  return true;
}
