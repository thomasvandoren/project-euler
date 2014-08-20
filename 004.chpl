/*
 * Largest palindrome product
 */

config const width = 3;

// Setup a domain, which will allow us to iterate from 999 down to 100 in two
// dimension, i.e. 999, 999; 999, 998; 999, 997; ... ; 998, 999; ... ; etc.
const min = 10 ** (width - 1),
  max = (10 ** width) - 1,
  D = {min..max by -1, min..max by -1};

// Returns whether or not the number is a palindrome.
proc isPalindrome(num) {
  var strNum = num: string;
  for i in 1..(strNum.length / 2) {
    if strNum.substring(i) != strNum.substring(strNum.length - i + 1) {
      return false;
    }
  }
  return true;
}

var maxResult = (0, -1, -1);
for (i, j) in D {
  var result = i * j;
  if result > maxResult(1) && isPalindrome(result) {
    maxResult = (result, i, j);
  }
}

writef("%di = %di * %di\n", maxResult(1), maxResult(2), maxResult(3));
