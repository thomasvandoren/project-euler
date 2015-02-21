/*
 * Lexicographic permutations
 */

use MathFunctions;

config const digits = 10,  // 10 --> 0..9
  permutation = 1000000,
  printPermutations = false;

proc main() {
  const elements = [n in 0..digits-1] n: string;
  for (p, i) in zip(permutations(elements), 1..) {
    if printPermutations then
      writeln(p);
    if i == permutation {
      writeln(p);
      break;
    }
  }
}
