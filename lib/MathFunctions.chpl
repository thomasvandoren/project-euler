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

// Yields proper divisors of n. Proper divisors of n are numbers less than n
// which divide evenly into n.
iter divisors(n) {
  var current = 1;

  while current <= n / 2 {
    yield current;

    do {
      current += 1;
    } while n % current != 0;
  }
}

// n!
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

// Print the Fibonacci number less than and equal to 4 million.
iter fibonacci(): BigInt {
  var current = new BigInt(1),
    next = new BigInt(1),
    tmp: BigInt;
  while true {
    yield current;

    current.add(current, next);
    current <=> next;
  }
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

// Returns sum of all divisors of n.
proc sumDivisors(n) {
  var sum = 0;
  for i in divisors(n) {
    sum += i;
  }
  return sum;
}
