/*
 * Maximum path sum I
 */

use Regexp;

config const triangle = "big",
  printResults = false;
const smallTriangle = "3\
7 4\
2 4 6\
8 5 9 3",
  bigTriangle = "75\
95 64\
17 47 82\
18 35 87 10\
20 04 82 47 65\
19 01 23 75 03 34\
88 02 77 73 07 63 67\
99 65 04 28 06 16 70 92\
41 41 26 56 83 40 80 70 33\
41 48 72 33 47 32 37 16 94 29\
53 71 44 65 25 43 91 52 97 51 14\
70 11 33 28 77 73 17 78 39 68 17 57\
91 71 52 38 17 14 91 43 58 50 27 29 48\
63 66 04 68 89 53 67 30 73 16 69 87 40 31\
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23";

proc main() {
  var t: string,
    lineCount = 0;

  // Determine which triangle to use.
  if triangle == "small" {
    t = smallTriangle;
  } else {
    t = bigTriangle;
  }

  // Count the number of lines in the triangle in order to figure out the size
  // of the triangle matrix.
  for i in t.split(compile("\n")) {
    lineCount += 1;
  }

  // Store the triangle matrix in a 2d array.
  var triangleMatrix: [{1..lineCount, 1..lineCount}] int;

  // Iterate through each line in the triangle.
  for (line, i) in zip(t.split(compile("\n")), 1..) {
    for (number, j) in zip(line.split(compile("\\s+")), 1..) {
      triangleMatrix[i, j] = number: int;
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
