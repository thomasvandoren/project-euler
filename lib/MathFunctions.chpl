/*
 * Math helper functions.
 */

// requires CHPL_GMP=gmp or system
use GMP;

// factorial(n) / (factorial(k) * factorial(n - k));
proc choose(n: int, k: int): BigInt {
  var result = factorial(n);
  result.div_q(Round.ZERO, result, factorial(k));
  result.div_q(Round.ZERO, result, factorial(n - k));
  return result;
}

proc factorial(n: int): BigInt {
  if n < 0 {
    halt("Error! non-positive factorial!?");
  } else if n == 0 {
    return new BigInt(1);
  } else {
    var result = factorial(n - 1);
    result.mul_ui(result, n: c_ulong);
    return result;
  }
}
