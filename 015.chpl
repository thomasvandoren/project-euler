/*
 * Lattice paths
 */

use MathFunctions;

config const gridSize = 20;

// The number of paths can be expressed as choose(gridSize + gridSize,
// gridSize), or choose(40, 20).
proc main() {
  writeln(choose(gridSize + gridSize, gridSize));
}
