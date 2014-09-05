/*
 * Power digit sum
 */

// requires CHPL_GMP=gmp or system
use GMP;
use MathFunctions;

config const exp = 1000;

proc main() {
  writeln(sumDigits(power(2, exp)));
}

// Returns base ** exp using BigInts to avoid integer overflow.
proc power(base, exp) {
  var result = new BigInt();
  result.pow_ui(new BigInt(base), exp: c_ulong);
  return result;
}
