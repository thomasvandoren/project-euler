/*
 * Names scores
 */

use IO;
use Sort;

config const nameFile = "p022_names.txt";

proc main() {
  var reader = open(nameFile, iomode.r).reader(),
    line: string;

  if ! reader.readline(line) then
    halt("Error: Reading file.");

  // Split the long line by commas, and then in parallel, strip the quotes from
  // each name.
  var names = stripQuotes(line.split(compile(",")));
  QuickSort(names);

  var sum = 0;
  for (name, i) in zip(names, 1..) {
    sum += nameScore(name, i);
  }
  writeln(sum);
}

// Return the name score of the given name. Name is the string name and order
// is the integer order in the sorted list.
proc nameScore(name, order) {
  const min = ascii("A") - 1;
  var sum = 0;
  for i in 1..name.length {
    sum += ascii(name.substring(i)) - min;
  }
  return sum * order;
}

// Return name without quotes.
proc stripQuotes(name: string): string {
  return name.substring(2..name.length-1);
}
