/*
 * Special Pythagorean triplet
 */

config const sum = 1000;
config const printTriplet = false;

proc main() {
  // Setup 3 dimensional domain for iterating over the entire 3 D space of
  // 1..sum for each a, b, c.
  const denseD = {1..sum, 1..sum, 1..sum};

  // This will find all triplets (three dimensions for a, b, c) that are
  // pythagorean triplets, and test if their sum is 1000. Use atomics to store
  // answer, since a and b will appear twice and we could have a race
  // condition.
  //
  // There is probably some optimizations that could be done here to reduce the
  // number of iterations.
  var resultA, resultB, resultC: atomic int;
  forall (a, b, c) in denseD {
    if exactSum(a, b, c) && isPythagoreanTriplet(a, b, c) {
      resultA.write(a);
      resultB.write(b);
      resultC.write(c);
    }
  }

  const a = resultA.read(),
    b = resultB.read(),
    c = resultC.read();

  if printTriplet {
    writef("%di = %di + %di + %di\n", sum, a, b, c);
    writef("%di^2 = %di^2 + %di^2\n", c, a, b);
  }
  writeln(a * b * c);
}

// Returns true when c ** 2 = a ** 2 + b ** 2, false otherwise.
proc isPythagoreanTriplet(a, b, c) {
  return c ** 2 == a ** 2 + b ** 2;
}

// Returns true when the sum of a, b, and c is exactly sum.
proc exactSum(a, b, c) {
  return a + b + c == sum;
}
