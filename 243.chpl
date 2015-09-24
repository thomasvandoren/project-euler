/*
 * Resilience
 */

use Assert;
use IO;
use MathFunctions;
use Regexp;

config const fraction = "15499/94744",
  debug = false;

proc main() {
  const (numerator, denominator) = parseFraction(fraction),
    targetResilience = 1.0 * numerator / denominator;

  for d in 2..max(int)-1 {
    const res = resilience(d);
    if debug then
      writeln("R(", d, ") = ", res);
    if res < targetResilience {
      writeln(d);
      break;
    }
  }
}


proc resilience(d) {
  var properFractionCount: atomic int;
  forall n in 1..d-1 {
    if gcd(n, d) == 1 {
      properFractionCount.add(1);
    }
  }
  return 1.0 * properFractionCount.read() / (d - 1);
}


proc parseFraction(f: string): (int, int) {
  const pattern = compile("(\\d+)\\s*/\\s*(\\d+)"),
    matches = pattern.matches(f, 2);
  assert(matches.size == 1, "Should be one match for fraction");

  const (numMatch, denMatch) = (matches[1](2), matches[1](3));
  assert(numMatch.matched && denMatch.matched, "numerator and denominator should be integers separated by /");

  const (numerator, denominator) = (f.substring(numMatch): int, f.substring(denMatch): int);
  return (numerator, denominator);
}
