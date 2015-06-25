/*
 * Non-abundant sums
 */

use MathFunctions;

const maxInt = 28123;

proc main() {
  const D = {1..maxInt};
  var abundantInts: sparse subdomain(D),
    allInts: [D] bool;

  for n in D {
    if isAbundant(n) {
      abundantInts += n;
    }
  }

  forall i in abundantInts {
    forall j in abundantInts {
      if i <= j && i + j <= maxInt {
        allInts[i + j] = true;
      }
    }
  }

  var sum = 0;
  for i in allInts.domain {
    if ! allInts[i] {
      sum += i;
    }
  }
  writeln(sum);
}

// Returns true if integer n is abundant. n is abundant if the sum of its
// proper divisors is greater than itself.
proc isAbundant(n: int): bool {
  return sumDivisors(n) > n;
}
