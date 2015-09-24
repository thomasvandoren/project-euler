/*
 * Path sum: two ways
 */

use Heap;
use IO;
use StringUtils;

config const mfile = "p081_matrix.txt",
  msize = 80,
  debug = false;

const INFINITY = -1;

proc main() {
  const fp = open(mfile, iomode.r, hints=IOHINT_CACHED),
    D = {1..msize, 1..msize};
  var A: [D] int,
    nodes: [D] Node;

  for (line, i) in zip(fp.lines(), 1..) {
    for (number, j) in zip(line.split(compile(",")), 1..) {
      if endsWith(number, "\n") then
        A[i, j] = number.substring(1..number.size-1): int;
      else
        A[i, j] = number: int;
    }
  }

  const manhattanDistance = 2 * (msize - 1) + 1;

  forall (i, j) in nodes.domain do
    nodes[i, j] = new Node(A[i, j],
                           i + j - 1 /* previous */,
                           manhattanDistance - i - j + 1 /* remaining */);

  forall (i, j) in nodes.domain {
    var node = nodes[i, j];
    if i + 1 <= nodes.domain.dim(1).high then
      node.down = nodes[i+1, j];
    if j + 1 <= nodes.domain.dim(2).high then
      node.right = nodes[i, j+1];
  }

  if debug then
    writeln(nodes[msize, msize]);

  var graph = nodes[1, 1],
    lastNode = nodes[msize, msize];

  // A* search
  var heap = new Heap(nodes.size, Node);

  // Set distance from root to its value.
  graph.distance = graph.value;

  // Add start node to heap.
  heap.insert(graph);

  while !heap.empty {
    var node = heap.extract();

    for neighbor in (node.right, node.down) {
      if neighbor == nil then
        continue;

      const newDist = node.distance + neighbor.value;
      if neighbor.distance == INFINITY || newDist < neighbor.distance {
        neighbor.distance = newDist;
        neighbor.prev = node;
        heap.insert(neighbor);
      }
    }

    if debug {
      if heap.size < 10 || heap.size % 100 == 0 then
        write(heap.size, " ");
    }
  }

  if debug {
    writeln();

    var node = lastNode,
      nodeList: [1..0] Node;
    while node != nil {
      nodeList.push_back(node);
      node = node.prev;
    }
    while nodeList.size > 0 {
      var n = nodeList[nodeList.size];
      write(n.value, " (", n.distance, ")", " -> ");
      nodeList.pop_back();
    }
    writeln();
  }

  writeln(lastNode.distance);
}



class Node {
  /* value at this location in grid */
  var value: int,

  /* number of vertices prior to this node, including this node */
    previous: int,

  /* remaining vertices, excluding this node */
    remaining: int,

  /* distance (sum of previous values) from initial node to here, including this node */
    distance = INFINITY,

  /* previous node that was visited on the ideal path */
    prev: Node = nil,

  /* node that is below current node */
    down: Node = nil,

  /* node that is to the right of current node */
    right: Node = nil;

  /* guess (heuristic for) the remaining distance based on distance so far */
  proc remainingDistance const {
    if distance == INFINITY then
      return INFINITY;
    else if previous == 0 then
      return value;
    else
      // remaining distance is the average distance per vertice so far, times the remaining number of vertices
      return distance / previous * remaining;
  }
}

inline proc <(a: Node, b: Node) {
  if a.distance == INFINITY && b.distance == INFINITY then
    return false;
  else if a.distance == INFINITY then
    return false;
  else if b.distance == INFINITY then
    return true;
  else
    return a.distance + a.remainingDistance < b.distance + b.remainingDistance;
}

inline proc <=(a: Node, b: Node) {
  if a.distance == INFINITY && b.distance == INFINITY then
    return true;
  else if a.distance == INFINITY then
    return false;
  else if b.distance == INFINITY then
    return true;
  else
    return a.distance + a.remainingDistance <= b.distance + b.remainingDistance;
}
