/*
 * Factorial digit sum
 */

use MathFunctions;

config const n = 100;

proc main() {
  writeln(sumDigits(factorial(n)));
}
