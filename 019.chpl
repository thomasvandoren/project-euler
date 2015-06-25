/*
 * Counting Sundays
 */

use Date;

config const start = "1901-01-01",
  end = "2000-12-31",
  printDates = false;

proc main() {
  const startDate = Date.fromIsoString(start),
    endDate = Date.fromIsoString(end);
  var count = 0;

  for d in months(startDate, endDate) {
    if d.weekday() == 0 {
      count += 1;
      if printDates {
        writeln(d);
      }
    }
  }

  writeln(count);
}

// Yield first of each month between start date and end date (inclusive).
//
// :type startDate: Date
// :arg startDate: start date
//
// :type endDate: Date
// :arg endDate: end date
//
// :rtype: Date
// :returns: first of the month
iter months(startDate, endDate) {
  var current = startDate;

  // If current is not the first of the month, increment month.
  if current.day != 1 {
    if current.month < 12 {
      current = new Date(current.year, current.month + 1, 1);
    } else {
      current = new Date(current.year + 1, 1, 1);
    }
  }

  // essentially, this is: (current <= endDate)
  while (current.year < endDate.year ||
         (current.year == endDate.year &&
          current.month < endDate.month) ||
         (current.year == endDate.year &&
          current.month == endDate.month &&
          current.day <= current.day)) {
    yield current;

    // Increment the current date to next month. Increment year if
    // needed. Ideally, this could be done as:
    //
    //   (current + TimeDelta(days=31)).replace(day=1)
    if current.month < 12 {
      current = new Date(current.year, current.month + 1, 1);
    } else {
      current = new Date(current.year + 1, 1, 1);
    }
  }
}
