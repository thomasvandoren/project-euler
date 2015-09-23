/*
 * Quadratic primes
 */

use MathFunctions;

config const maxValue = 1000,
  debug = false;

proc main() {
  const m = maxValue - 1,
    space = {-m..m, -m..m};
  var answer: (int, int),
    answerPrimeCount = 0;
  for (a, b) in space {
    const primeCount = countPrimes(a, b);
    if primeCount > answerPrimeCount {
      answer = (a, b);
      answerPrimeCount = primeCount;
    }
  }
  const (a, b) = answer;
  if debug then
    writeln("a: ", a, " b: ", b, " primeCount: ", answerPrimeCount);
  writeln(a * b);
}


proc countPrimes(a, b) {
  var n = 0;
  while isPrime(calculate(n, a, b)) do
    n +=1;
  return n + 1;
}


proc calculate(n, a, b) {
  return n * n + a * n + b;
}
