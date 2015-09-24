
proc endsWith(s, suffix) {
  return suffix.size == 0 ||
    s.substring((s.size - suffix.size + 1)..s.size) == suffix ||
    (s.size == suffix.size && s == suffix);
}
