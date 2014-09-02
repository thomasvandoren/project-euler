/*
 * Power digit sum
 */

// requires CHPL_GMP=gmp or system
use GMP;

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

// Returns sum of individual digits of n. n is serialized as string, then each
// character is cast to an int, and added together.
proc sumDigits(n) {
  var nStr = n: string,
    result = 0;
  for i in 1..nStr.length {
    result += nStr.substring(i): int;
  }
  return result;
}
