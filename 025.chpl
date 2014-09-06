/*
 * 1000-digit Fibonacci number
 */

use MathFunctions;

config const digits = 1000,
  printNum = false;

proc main() {
  for (d, n) in zip(fibonacci(), 1..) {
    var dStr = d: string;
    if dStr.length >= digits {
      if printNum {
        writeln("F(", n, ") = ", d);
      }
      writeln(n);
      break;
    }
  }
}
