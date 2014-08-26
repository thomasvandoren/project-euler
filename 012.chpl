/*
 * Highly divisible triangular number
 */

config const minDivisors = 500,
  printNumbers = false;

proc main() {
  for t in triangleNumbers() {

    if printNumbers then
      writef("%di: ", t);

    var count = 0;
    for f in factors(t) {
      count += 1;

      if printNumbers then
        writef("%di, ", f);
    }
    if printNumbers then
      writeln();

    if count > minDivisors {
      writeln(t);
      break;
    }
  }
}

// Yield all the factors of n.
iter factors(n) {
  // Yield 1 and n first, then all intermediate factors.
  yield 1;
  yield n;

  var i = 2;
  while (i < sqrt(n)) {
    if n % i == 0 {
      yield i;
      yield n / i;
    }
    i += 1;
  }

  if i ** 2 == n {
    yield i;
  }
}

// Yield triangle numbers infinitely. Up to caller to break iteration.
iter triangleNumbers() {
  var num = 1,
    triangleNum = num;
  for i in 1..max(int) {
    yield triangleNum;
    num += 1;
    triangleNum += num;
  }
}
