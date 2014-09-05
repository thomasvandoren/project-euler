/*
 * Amicable numbers
 */

config const maxNum = 10000,
  printPairs = false;

proc main() {
  var allSums: [{1..maxNum-1}] int,
    sum: atomic int;

  // Calculate all the sumDivisors first.
  forall n in allSums.domain {
    allSums[n] = sumDivisors(n);
  }

  // Iterate over all pairs where a < b. This ensures that duplicates are not
  // added to sum. For example, without this, both 220,284 and 284,220 would be
  // considered.
  forall a in 1..maxNum-1 {
    forall b in a+1..maxNum-1 {
      if allSums[a] == b && allSums[b] == a {
        sum.write(sum.read() + a + b);

        if printPairs {
          writef("d(%di) = %di\nd(%di) = %di\n", a, b, b, a);
        }
      }
    }
  }

  writeln(sum.read());
}

// Returns true if a and b are amicable numbers. If sumDivisors(a) == b,
// sumDivisors(b) == a, and a != b, then a and b are amicable.
proc amicable(a, b) {
  return a != b && sumDivisors(a) == b && sumDivisors(b) == a;
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

// Returns sum of all divisors of n.
proc sumDivisors(n) {
  var sum = 0;
  for i in divisors(n) {
    sum += i;
  }
  return sum;
}
