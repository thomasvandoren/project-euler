/*
 * Number spiral diagonals
 */

config const spiralSize = 1001,
  debug = false;

proc main() {
  const D = {1..spiralSize, 1..spiralSize},
    center = (spiralSize - 1) / 2 + 1;
  var A: [D] int = 0,
    lastX = center,
    lastY = center,
    x = center + 1,
    y = center;

  if debug then
    writeln((center, center));
  A[center, center] = 1;

  for value in 2..A.size {
    if debug then
      writeln((x, y));
    A[y, x] = value;

    const horizontal = lastY == y,
      vertical = lastX == x,
      horizontalRight = horizontal && lastX < x,
      horizontalLeft = horizontal && lastX > x,
      verticalUp = vertical && lastY > y,
      verticalDown = vertical && lastY < y;

    if horizontalRight && A[y+1, x] != 0 {
      // Keep moving right, cannot move down yet
      lastX = x;
      x +=1;
    } else if horizontalRight {
      // Can move down
      lastX = x;
      y += 1;
    } else if verticalDown && A[y, x-1] != 0 {
      // Keep moving down, cannot move left yet
      lastY = y;
      y += 1;
    } else if verticalDown {
      // Can move left
      lastY = y;
      x -= 1;
    } else if horizontalLeft && A[y-1, x] != 0 {
      // Keep moving left, cannot move up yet
      lastX = x;
      x -= 1;
    } else if horizontalLeft {
      // Can move up
      lastX = x;
      y -= 1;
    } else if verticalUp && A[y, x+1] != 0 {
      // Keep moving up, cannot move right yet
      lastY = y;
      y -= 1;
    } else if verticalUp {
      // Can move right
      lastY = y;
      x += 1;
    }
  }

  if debug then
    writeln("\n", A, "\n");

  var diagSum = 0;
  for (x, y) in zip(1..spiralSize, 1..spiralSize) {
    if debug then
      writeln((x, y), " = ", A[y, x]);
    diagSum += A[y, x];
  }
  for (x, y) in zip(1..spiralSize, 1..spiralSize by -1) {
    if debug then
      writeln((x, y), " = ", A[y, x]);
    diagSum += A[y, x];
  }
  // The center spot was counted twice, so remove it.
  diagSum -= A[center, center];
  writeln(diagSum);
}


