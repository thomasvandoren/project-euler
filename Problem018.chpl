/*
 * functions for solving 18 and 67.
 */

use Regexp;

config const printResults = false;

proc calcMaxSum(t) {
  var lineCount = 0;

  // Count the number of lines in the triangle in order to figure out the size
  // of the triangle matrix.
  for i in t.split(compile("\n")) {
    lineCount += 1;
  }

  // Store the triangle matrix in a 2d array.
  var triangleMatrix: [{1..lineCount, 1..lineCount}] int;

  // Iterate through each line in the triangle.
  for (line, i) in zip(t.split(compile("\n")), 1..) {
    if line.length > 0 {
      for (number, j) in zip(line.split(compile("\\s+")), 1..) {
        triangleMatrix[i, j] = number: int;
      }
    }
  }

  writeln(maxSum(triangleMatrix));
}

// Find and return the sum of the adjacent values in the triangle.
proc maxSum(triangleMatrix) {
  var maxDepth = triangleMatrix.domain.dim(1).length,
    maxWidth = triangleMatrix.domain.dim(2).length;

  var results: [triangleMatrix.domain] int;

  results[maxDepth, 1..maxWidth] = triangleMatrix[maxDepth, 1..maxWidth];

  for depth in 1..(maxDepth-1) by -1 {
    forall width in 1..depth {
      var sumLeft = results[depth + 1, width],
        sumRight = results[depth + 1, width + 1],
        maxValue = max(sumLeft, sumRight);
      results[depth, width] = triangleMatrix[depth, width] + maxValue;
    }
  }

  if printResults {
    writeln(results);
  }
  return results[1, 1];
}
