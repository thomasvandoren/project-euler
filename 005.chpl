/*
 * Smallest multiple
 */

config const rangeMax = 20;

const values: [{1..rangeMax}] int;
forall i in 1..rangeMax {
  values[i] = i;
}

proc isMultiple(value: int, numbers: [] int) {
  for num in numbers {
    if value % num != 0 {
      return false;
    }
  }
  return true;
}

// Return least common multiple for list of ints.
proc lcm(numbers: [] int) {
  var maxNum = max reduce numbers,
    value = maxNum;

  while (!isMultiple(value, numbers)) {
    value += maxNum;
  }

  return value;
}

writeln(lcm(values));
