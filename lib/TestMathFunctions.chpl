
use MathFunctions;

writeln();
writeln("TESTING: permutations()");
writeln("----------------------------------------");
const A = ["A", "B", "C", "D"];

for p in permutations(A) {
  writeln(p);
}
for p in permutations(A, 4) {
  writeln(p);
}


writeln();
writeln("TESTING: gcd");

writeln(gcd(3, 4));
writeln(gcd(10, 20));
writeln(gcd(1, 15));
writeln(gcd(50, 100, 75, 125));
writeln(gcd([1071, 462]));
writeln(gcd(100..200 by 4));
