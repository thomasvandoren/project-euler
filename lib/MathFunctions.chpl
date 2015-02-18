/*
 * Math helper functions.
 */

use Containers;

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

  var r = (number ** 0.5): uint,
    f: uint = 5;
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

// Sieve of Eratosthenes
// Generates first k prime numbers.
//
// Inspired by: http://stackoverflow.com/a/568618
// And:         http://code.activestate.com/recipes/117119/#c4
iter primes(k: uint, param debug=false): uint {
  if k >= 1 then
    yield 2;

  var i: uint = 1,
    q: uint = 3;
  var D: domain(uint),
    A: [D] uint;

  while true {
    if ! D.member(q) {
      if debug then
        assert(isPrime(q));

      yield q;

      i += 1;
      if i == k then
        break;

      A[q * q] = 2 * q;
    } else {
      const p = A[q];
      var pq = p + q;
      while D.member(pq) do
        pq += p;
      A[pq] = p;
      D -= q;
    }
    q += 2;
  }
}

// Sieve of Eratosthenes up to max value.
// Generates prime numbers less than or equal to `m`.
iter primesUpTo(m: uint, param debug=false): uint {
  if m < 2 then
    halt("no primes less than 2");

  if m >= 2 then
    yield 2;

  var q: uint = 3,
    D: domain(uint),
    A: [D] uint;

  while q <= m {
    if ! D.member(q) {
      if debug then
        assert(isPrime(q));

      yield q;

      A[q * q] = 2 * q;
    } else {
      const p = A[q];
      var pq = p + q;
      while D.member(pq) do
        pq += p;
      A[pq] = p;
      D -= q;
    }
    q += 2;
  }
}

/* // Yield the first `k` prime numbers as BigInts. */
/* iter bigPrimes(k: int(64)): BigInt { */
/*   var i = 0, */
/*     q = new BigInt(2); */
/*   var D: domain(BigInt); */
/*   var A: [D] domain(BigInt); */

/*   while true { */
/*     if ! D.member(q) { */
/*       yield q; */
/*       i += 1; */
/*       var qSquared = new BigInt(); */
/*       qSquared.mul(q, q); */
/*       D += qSquared; */
/*       A[qSquared] += q; */
/*     } else { */
/*       for p in A[q] { */
/*         var pq = new BigInt(); */
/*         pq.add(p, q); */
/*         D += pq; */
/*         A[pq] = p; */
/*       } */
/*       D.remove(q); */
/*     } */
/*     if i == k { */
/*       break; */
/*     } */
/*     q += 1; */
/*   } */
/* } */

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
