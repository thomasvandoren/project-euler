/*
 * Largest prime factor
 */

config const num = 600851475143;

// Calculate the largest prime factor of num and return the result. This uses
// the simple trial division.
proc largestPrimeFactor(num) {
  var biggestPF = 1,
    d = 2,
    n = num;
  while (d * d <= n) {
    while (n % d == 0) {
      biggestPF = d;
      n /= d;
    }
    d += 1;
  }

  if n > 1 {
    biggestPF = n;
  }

  return biggestPF;
}

writeln(largestPrimeFactor(num));
