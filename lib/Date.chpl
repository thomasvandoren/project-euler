/*
 * Date module a la python...
 */

// Requires CHPL_REGEXP=re2.
use Regexp;

// Min and max years that this module supports.
const MINYEAR = 1,
  MAXYEAR = 9999;

const _daysInMonth: [{1..12}] int = [
  31,  // January
  28,  // February
  31,  // March
  30,  // April
  31,  // May
  30,  // June
  31,  // July
  31,  // August
  30,  // September
  31,  // October
  30,  // November
  31   // December
];

const _weekdayStrings: [{0..6}] string = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

record Date {
  var year, month, day: int;

  proc Date(year: int, month: int, day: int) {
    this.year = year;
    this.month = month;
    this.day = day;
    checkDate();
  }

  /* Validates all values for this instance. Halts if anything is invalid.
   */
  proc checkDate() {
    checkYear();
    checkMonth();
    checkDay();
  }

  /* Validates the day for this instance. Ensures that day is between 1 and
   * daysInMonth(). If not, it halts.
   */
  proc checkDay() {
    if day < 1 || day > daysInMonth() then
      halt("Error: Invalid day: ", day);
  }

  /* Validates the month for this instance. Ensures that month is between 1 and
   * 12 inclusive. If not, it halts.
   */
  proc checkMonth() {
    if month < 1 || month > 12 then
      halt("Error: Invalid month: ", month);
  }

  /* Validates the year for this instance. Ensures that year is between MINYEAR
   * and MAXYEAR inclusive. If not, it halts.
   */
  proc checkYear() {
    if year < MINYEAR || year > MAXYEAR then
      halt("Error: Invalid year: ", year);
  }

  /* Return new instance of Date with same attribute that current instance.
   */
  proc copy() {
    return new Date(this.year, this.month, this.day);
  }

  /* Number of days in year preceding first day of instance's month. It simply
   * iterates through all the months before this instance's month and adds up
   * the number of days in the month.
   *
   * :rtype: int
   * :returns: Number of days in year preceding first day of this instance's
   *     month.
   */
  proc daysBeforeMonth(): int {
    var result = 0;
    for i in 1..month-1 do
      result += _daysInMonth[i];
    if month > 2 && isLeapYear() then
      result += 1;
    return result;
  }

  /* Number of days before Jan-01 of this instance's year. The formula is::
   *
   *    y = y - 1
   *    365*y + y/4 - y/100 + y/400
   *
   * This is 365 * years, adjusting for leap years.
   *
   * :rtype: int
   * :returns: Number of days before Jan-01 of this instance's year.
   */
  proc daysBeforeYear(): int {
    var y = year - 1;
    return y * 365 + y / 4 - y / 100 + y / 400;
  }

  /* Returns number days in month for this year.
   *
   * :rtype: int
   * :returns: Number of days in month of this year.
   */
  proc daysInMonth(): int {
    if month == 2 && isLeapYear() then
      return 29;
    return _daysInMonth[month];
  }

  /* Returns true if this instance's year is a leap year. Leap years are
   * divisible by 4 and any century divisible by 400.
   *
   * :rtype: bool
   * :returns: true if leap year, false otherwise
   */
  proc isLeapYear(): bool {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  /* Returns proleptic Gregorian ordinal for the year, month, and day.
   *
   * January 1 of year 1 is day 1. Only the year, month, and day values
   * contribute to the result.
   *
   * :rtype: int
   * :returns: Proleptic Gregorian ordinal.
   */
  proc toOrdinal(): int {
    return daysBeforeYear() + daysBeforeMonth() + day;
  }

  /* Returns day of the week. Sunday is 0, Monday is 1, Tuesday is 2, and so on
   * up to Saturday as 6.
   *
   * :rtype: int
   * :returns: Day of week.
   */
  proc weekday(): int {
    return toOrdinal() % 7;
  }

  /* Returns day of week in long text format (i.e. "Monday", "Tuesday", etc)
   * for this date.
   *
   * :rtype: string
   * :returns: String representation of weekday for this date.
   */
  proc weekdayText(): string {
    return _weekdayStrings[weekday()];
  }
}

/* Returns new date instance from ISO 8601 formatted date string. Recognized
 * formats include:
 *
 * * YYYY-MM-DD
 *
 * TODO: these --v
 *
 * * YYYYMMDD
 * * YYYY
 * * YYYY-MM
 *
 * :type dateStr: string
 * :arg dateStr: ISO 8601 formatted date string
 *
 * :rtype: Date
 * :returns: new Date instance
 */
proc type Date.fromIsoString(dateStr: string): Date {
  // TODO: These are naive patterns that will accept invalid values for month
  //       and day in particular. The Date initializer will still catch the
  //       invalid Date, but a more informative error could be given here.
  //       (thomasvandoren, 2014-09-02)
  const isoPatterns = [
    "^\\d{4}-\\d{2}-\\d{2}$",
    "^\\d{4}\\d{2}\\d{2}$",
    "^\\d{4}$",
    "^\\d{4}-\\d{2}$"
  ];
  var regex = compile("^(\\d{4})-(\\d{2})-(\\d{2})$"),
    matches = regex.matches(dateStr, 3),
    y, m, d: int;
  for match in matches {
    y = dateStr.substring(match[2]): int;
    m = dateStr.substring(match[3]): int;
    d = dateStr.substring(match[4]): int;
  }
  return new Date(y, m, d);
}

const MINDATE = new Date(MINYEAR, 1, 1),
  MAXDATE = new Date(MAXYEAR, 12, 31);

proc type Date.min {
  return MINDATE.copy();
}

proc type Date.max {
  return MAXDATE.copy();
}
