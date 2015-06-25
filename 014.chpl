/*
 * Longest Collatz sequence
 */

config const maxStart = 1000000,
  printSeq = false;

proc main() {
  var maxCount, startNum: int;

  // Calculate all Collatz counts for 1 to maxStart-1.
  const D: domain(1) = 1..maxStart-1,
    collatzCounts: [D] int = [i in D] countCollatz(i);

  // Find the maximum Collatz count of those calculated.
  for (count, i) in zip(collatzCounts, 1..) {
    if count > maxCount {
      maxCount = count;
      startNum = i;
    }
  }

  const answer = startNum;
  if printSeq then
    printCollatz(answer);
  writeln(answer);
}

// Yield each number in the Collatz sequence starting with n and ending with 1.
iter collatz(n) {
  var current = n;

  while (current >= 1) {
    yield current;
    if current == 1 {
      break;
    } else if current % 2 == 0 {
      current = current / 2;
    } else {
      current = 3 * current + 1;
    }
  }
}

// Returns the length of the Collatz sequence starting at n.
proc countCollatz(n) {
  var count = 0;
  for i in collatz(n) {
    count += 1;
  }
  return count;
}

// Print the Collatz sequence.
proc printCollatz(n) {
  var length = 0;
  write(n, ": ");
  for i in collatz(n) {
    length += 1;
    if i == 1 {
      writeln(i);
    } else {
      write(i, " -> ");
    }
  }
  writeln("length: ", length);
}