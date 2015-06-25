/*
 * Amicable numbers
 */

use MathFunctions;

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
          writef("d(%n) = %n\nd(%n) = %n\n", a, b, b, a);
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
