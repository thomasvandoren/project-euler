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

  const num = number.safeCast(uint);
  var r = (number ** 0.5): uint,
    f: uint = 5;
  while (f <= r) {
    if num % f == 0 {
      return false;
    } else if num % (f + 2) == 0 {
      return false;
    }
    f += 6;
  }
  return true;
}

// Yield successive permutations of the elements.
//
// Inspired by: https://docs.python.org/2/library/itertools.html#itertools.permutations
iter permutations(elements: [] string, length=-1): string {
  var n = elements.size;
  var r = length;

  // Default for r is length.
  if r == -1 then
    r = n;

  // If permutations are longer than number of elements, no permutations are
  // possible.
  if r > n then
    return;

  var indices: [{0..n-1}] int = [i in 0..n-1] i,
    cycles: [{0..n-1}] int = [c in n-r+1..n by -1] c;

  var perm = "";
  for i in indices[0.. # r] do
    perm += elements[i+1];
  yield perm;

  while true {
    var done = true;
    for i in 0..r-1 by -1 {
      cycles[i] -= 1;
      if cycles[i] == 0 {
        var rightInd = indices[i+1..],
          leftInd = indices[i..i];
        indices[i.. # rightInd.size] = rightInd;
        indices[(i + rightInd.size)..] = leftInd;
        cycles[i] = n - i;
      } else {
        indices[i] <=> indices[indices.size - cycles[i]];

        perm = "";
        for i in indices[0.. # r] do
          perm += elements[i+1];
        yield perm;

        done = false;
        break;
      }
    }

    // Did not yield a permutation, so we're done.
    if done then
      return;
  }
}

// Sieve of Eratosthenes
// Generates first k prime numbers.
//
// Inspired by: http://stackoverflow.com/a/568618
// And:         http://code.activestate.com/recipes/117119/#c4
iter primes(k: uint, param debug=false): uint {
  if k >= 1 then
    yield 2;

  // If only one prime requested, stop here.
  if k == 1 then
    return;

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

  if m == 2 then
    return;

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
