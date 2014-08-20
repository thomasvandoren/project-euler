/*
 * Sum square difference
 */

config const rangeMax = 100;
const values = {1..rangeMax};

proc sumOfSquares(numbers) {
  return + reduce numbers ** 2;
}

proc squareOfSum(numbers) {
  return (+ reduce numbers) ** 2;
}

writeln(squareOfSum(values) - sumOfSquares(values));
