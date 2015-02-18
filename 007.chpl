/*
 * 10001st prime
 */

use MathFunctions;

config const n = 10001;
config const printPrimes = false;

// Returns the first <count> prime numbers beginning with 2, the first prime.
// This was more for fun than to be useful.
iter primes(count) {
  if count >= 1 {
    yield 2;
  }
  var current = 3;
  for i in 2..count {
    yield current;

    do {
      current += 2;
    } while !isPrime(current);
  }
}

proc getPrime(count) {
  var result = -1;
  for (value, i) in zip(primes(count), 1..count) {
    if printPrimes {
      writef("%di: %di\n", i, value);
    }
    if i == count {
      result = value;
    }
  }
  return result;
}

writeln(getPrime(n));
