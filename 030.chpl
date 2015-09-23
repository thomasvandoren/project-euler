/*
 * Digit fifth powers
 */

config const power = 5,
  debug = false;

proc main() {
  var sum: atomic int;
  forall n in 10..10000000 { // arbitrarily chosen "big" number...
    if n == sumOfPowers(n, power) {
      if debug then
        writeln(n);
      sum.fetchAdd(n);
    }
  }
  writeln(sum.read());
}

proc sumOfPowers(n, p) {
  var sum = 0,
    d = n;
  while d > 0 {
    sum += (d % 10) ** p;
    d /= 10;
  }
  return sum;
}
