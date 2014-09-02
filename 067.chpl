/*
 * Maximum path sum II
 */

use IO;
use Problem018;

config const triangleFile = "p067_triangle.txt";

proc main() {
  // TODO: Write future/figure out how to read entire file and then strip off
  //       tailing/leading white space. (thomavandoren, 2014-09-01)
  var fp = open(triangleFile, iomode.r),
    giantTriangle = join(fp.lines());
  fp.close();
  calcMaxSum(giantTriangle);
}

proc join(stuff) {
  var result = "";
  for value in stuff {
    result += value;
  }
  return result;
}
