use Assert;
use GMP;
use Random;
use Time;

use Heap;

// constructors
writeln(new Heap(int));
writeln(new Heap(int(8)));
writeln(new Heap(uint));
writeln(new Heap(real));
writeln(new Heap(BigInt));
writeln(new Heap(string));
writeln(new Heap(c_string));
writeln(new Heap(Timer));
writeln(new Heap(RandomStream));
writeln(new Heap(555, int));


// writeThis() no values
var h = new Heap(int);
writeln(h);


// insert()
for i in 1..10 do
  h.insert(i);
h.printTree();


// empty, size, peek()
assert(h.peek() == 1);
assert(!h.empty);
assert(h.size == 10);


// extract()
while !h.empty do
  writeln(h.extract());
assert(h.empty);
assert(h.size == 0);
