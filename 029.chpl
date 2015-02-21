/*
 * Distinct powers
 */

use GMP;

config const maxInt = 100;

proc main() {
  var results: [1..0] BigInt;

  for a in 2..maxInt {
    for b in 2..maxInt {
      var p = new BigInt();
      p.ui_pow_ui(a: uint, b: uint);
      recordResult(results, p);
    }
  }

  writeln(results.size);

  for r in results do
    delete r;
}

// Check if the result already exists. If not, add it to the results array.
proc recordResult(ref results, power: BigInt) {
  var exists: atomic bool;
  forall r in results {
    if power.cmp(r) == 0 then
      exists.write(true);
  }
  if !exists.read() then
    results.push_back(power);
  else
    delete power;
}
