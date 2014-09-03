/*
 * Verify Date module.
 */

use Date;

proc printDateInfo(d: Date) {
  writeln("Date: ", d);
  writeln("Days before month: ", d.daysBeforeMonth());
  writeln("Days before year: ", d.daysBeforeYear());
  writeln("Days in month: ", d.daysInMonth());
  writeln("Leap year: ", d.isLeapYear());
  writeln("Ordinal: ", d.toOrdinal());
  writeln("Weekday: ", d.weekday());
  writeln("Weekday: ", d.weekdayText());

  writeln();
}

printDateInfo(new Date(2014, 9, 2));
printDateInfo(new Date(1, 1, 1));
printDateInfo(new Date(9999, 12, 31));
printDateInfo(MINDATE);
printDateInfo(MAXDATE);

printDateInfo(new Date(2014, 8, 31));
for i in 1..7 do
  printDateInfo(new Date(2014, 9, i));

printDateInfo(DateFromIsoString("2014-09-02"));
printDateInfo(DateFromIsoString("2000-02-29"));

for i in 1..12 do
  printDateInfo(new Date(1776, i, 1));
