module Heap {

  use IO;

  /*
    Binary min-heap implementation using a 1-D array.

    In order to use this Heap, less-than and less-than-or-equal binary
    operators must be defined for the generic type.

    TODO: Can we limit this to one binary op required? (thomasvandoren, 2015-09-22)

    TODO: What about distributed memory support? Could the user pass in a
          domain to use, e.g. one dmapped to a block distribution?
          (thomasvandoren, 2015-09-22)
   */
  class Heap {
    type T;
    var _size: int = 0,
      _domain: domain(1),
      _values: [_domain] T;

    proc Heap(type T) {
      _domain = {1..11};
    }

    proc Heap(initialCapicity: int, type T) {
      _domain = {1..initialCapicity};
    }

    proc size const {
      return _size;
    }

    proc empty const {
      return size == 0;
    }

    proc writeThis(f: Writer) {
      f <~> "Heap(T=";
      f <~> typeToString(T);
      f <~> ", size=";
      f <~> size;
      f <~> ")";
    }

    proc writeTree(ch: channel) {
      ch.writeln(this);
      _writeTree(1, 0, ch);
    }

    proc _writeTree(idx: int, indentLevel: int, ch: channel) {
      if idx > size then
        return;

      _writeTree(2 * idx + 1, indentLevel + 1, ch);

      for i in 1..indentLevel do
        ch.write("    ");
      ch.writeln(_values[idx]);

      _writeTree(2 * idx, indentLevel + 1, ch);
    }

    proc printTree() {
      writeTree(stdout);
    }

    proc insert(value: T) {
      if size == _values.size then
        _expandDomain();

      _size += 1;
      _values[size] = value;
      _siftUp(size);
    }

    proc _expandDomain() {
      const lo = _domain.low,
        delta = _domain.high - lo,
        hi = lo + 2 * delta;
      _domain = {lo..hi};
    }

    proc _siftUp(idx: int) {
      var currentIndex = idx,
        parentIndex = currentIndex / 2;
      
      while parentIndex >= 1 && _values[currentIndex] < _values[parentIndex] {
        currentIndex = parentIndex;
        parentIndex = currentIndex / 2;
      }
    }

    proc peek(): T {
      if empty then
        halt("Heap is empty.");
      return _values[1];
    }

    proc extract(): T {
      if empty then
        halt("Heap is empty.");

      const result = peek();
      _values[1] = _values[size];
      _size -= 1;
      _siftDown();
      return result;
    }

    proc _siftDown() {
      var currentIndex = 1,
        left = 2 * currentIndex,
        right = 2 * currentIndex + 1;

      while right <= size || left <= size {
        const current = _values[currentIndex],
          hasRight = right <= size;
        var done = current <= _values[left];

        if hasRight then
          done &&= current <= _values[right];

        if done then
          break;

        if !hasRight || _values[left] < _values[right] {
          _values[currentIndex] <=> _values[left];
          currentIndex = left;
        } else {
          _values[currentIndex] <=> _values[right];
          currentIndex = right;
        }

        left = 2 * currentIndex;
        right = 2 * currentIndex + 1;
      }
    }

    proc clear() {
      _size = 0;
    }

  }

}
