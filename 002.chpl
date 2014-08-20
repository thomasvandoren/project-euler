/*
 * Even Fibonacci number
 */

config const max = 4000000;
var sum = 0;

// Print the Fibonacci number less than and equal to 4 million.
iter fibonacci() {
  var current = 1,
    next = 1;
  while current <= max {
    yield current;
    current += next;
    current <=> next;
  }
}

for i in fibonacci() {
  if i % 2 == 0 {
    sum += i;
  }
}

writeln(sum);
