/*
 * Multiples of 3 and 5
 */

config const max = 1000;
var sum = 0;

for i in 0.. # max {
  if i % 3 == 0 || i % 5 == 0 {
    sum += i;
  }
}

writeln(sum);
