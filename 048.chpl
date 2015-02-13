/*
 * Self powers
 */

use GMP;

config const maxPower = 1000;
config const debug = false;

proc main() {
  var sum = new BigInt(),
    iSquared = new BigInt(1);

  // Compute the value 1**1 + 2**2 + 3**3 + ... + maxPower**maxPower
  for i in 1..maxPower {
    iSquared.ui_pow_ui(i: uint, i: uint);
    sum.add(sum, iSquared);
  }

  if debug then
    writeln("sum = ", sum);

  // Grab the last 10 digits.
  var answer = sum: string;
  const len = answer.length;
  answer = answer.substring(len-9..len);

  writeln(answer);
}
