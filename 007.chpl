/*
 * 10001st prime
 */

config const n = 10001;
config const printPrimes = false;

// This is a fairly optimized version of calculating if a number is prime or
// not.
// See: http://stackoverflow.com/a/15285588
proc isPrime(number) {
  if number == 2 || number == 3 {
    return true;
  } else if number < 2 || number % 2 == 0 {
    return false;
  } else if number < 9 {
    return true;
  } else if number % 3 == 0 {
    return false;
  }

  var r = (number ** 0.5): int,
    f = 5;
  while (f <= r) {
    if number % f == 0 {
      return false;
    } else if number % (f + 2) == 0 {
      return false;
    }
    f += 6;
  }
  return true;
}

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
