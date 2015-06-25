
use MathFunctions;

writeln();
writeln("TESTING: permutations()");
writeln("----------------------------------------");
const A = ["A", "B", "C", "D"];

for p in permutations(A) do
  writeln(p);
for p in permutations(A, 4) do
  writeln(p);

//writeln(permutations(A, 1));
//writeln(permutations(A, 2));
//writeln(permutations(A, 3));
