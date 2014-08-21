/*
 * Summation of primes
 */

config const max = 2000000;

proc main() {
  var sum = 0;
  for p in primes(max) {
    sum += p;
  }
  writeln(sum);
}

// TODO: If primes iter and isPrime function is used again, factor into common
//       module. (thomasvandoren, 2014-08-20)

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

// Returns prime numbers below the given maxNum (exclusive).
iter primes(maxNum) {
  if maxNum >= 2 {
    yield 2;
  }
  var current = 3;
  while current < maxNum {
    yield current;

    do {
      current += 2;
    } while !isPrime(current);
  }
}
