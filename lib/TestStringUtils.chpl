use StringUtils;

// true
writeln("TRUE");
writeln(endsWith("", ""));
writeln(endsWith("hello", "hello"));
writeln(endsWith("hello\n", "\n"));
writeln(endsWith("hello", "llo"));
writeln(endsWith("hello", ""));

// false
writeln("FALSE");
writeln(endsWith("", "hello"));
writeln(endsWith("hello", "olleh"));
writeln(endsWith("", "a"));
