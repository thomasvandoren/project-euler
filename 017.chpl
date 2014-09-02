/*
 * Number letter counts
 */

config const start = 1;
config const end = 1000;
config const printNums = false;

proc main() {
  var letterCount = 0;
  for i in start..end {
    var w = words(i),
      cl = countLetters(w);
    letterCount += cl;

    if printNums {
      writeln(i, ": ", w, " (", cl, ")");
    }
  }
  writeln(letterCount);
}

// Count the letters in the given string. It only considers ascii
// characters. Hyphens and spaces, for example, are not counted.
proc countLetters(w) {
  var count = 0;
  for i in 1..w.length {
    if isLetter(w.substring(i)) {
      count += 1;
    }
  }
  return count;
}

// Returns true if l is a letter (a-z or A-Z). False otherwise.
proc isLetter(l) {
  if l.length != 1 {
    halt("isLetter accepts single character strings.");
  }
  var a = ascii(l),
    isUpper = a >= 65 && a <= 90,
    isLower = a >= 97 && a <= 122;
  return isUpper || isLower;
}

// Return textual for of integer n.
proc words(n) {
  const D = {0..9},
    tens: [D] string = ["ZERO",
                        "TEENS",
                        "twenty",
                        "thirty",
                        "forty",
                        "fifty",
                        "sixty",
                        "seventy",
                        "eighty",
                        "ninety"],
    teens: [D] string = ["ten",
                         "eleven",
                         "twelve",
                         "thirteen",
                         "fourteen",
                         "fifteen",
                         "sixteen",
                         "seventeen",
                         "eighteen",
                         "nineteen"],
    ones: [D] string = ["ZERO",
                        "one",
                        "two",
                        "three",
                        "four",
                        "five",
                        "six",
                        "seven",
                        "eight",
                        "nine"];

  // Special case since know problem size has max of 1000.
  if n == 1000 {
    return "one thousand";
  } else if n > 1000 {
    halt("Error: words only works for integers from 1 to 1000 inclusive.");
  }

  var result = "",
    digitOnes = n % 10,
    digitTens = n / 10 % 10,
    digitHundreds = n / 100 % 10;

  if digitHundreds > 0 {
    result += ones[digitHundreds] + " hundred";
  }

  if digitHundreds > 0 && (digitTens > 0 || digitOnes > 0) {
    result += " and ";
  }

  if digitTens >= 2 {
    result += tens[digitTens];
    if digitOnes > 0 {
      result += " " + ones[digitOnes];
    }
  } else if digitTens == 1 {
    result += teens[digitOnes];
  } else if digitTens == 0 && digitOnes > 0 {
    result += ones[digitOnes];
  }

  return result;
}
