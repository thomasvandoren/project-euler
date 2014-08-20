Project Euler
=============

Project Euler, in [Chapel](http://chapel.cray.com/)!

Run the solutions
-----------------

```bash
make run-all

# For a single solution:
make 008 && ./008
```

Compiling the solutions
-----------------------

Make sure to use the `--fast` flag when compiling these solutions with Chapel.

```bash
chpl --fast <name>.chpl
# e.g.
chpl --fast 001.chpl && ./a.out
```

Misc
----

Most of the solutions use `config`s for the size/range/etc, so it is possible
to run smaller or larger problem sizes by passing a runtime argument (look for
`config const <var name>` at the top of the source file). The default is always
set to solve the Project Euler problem.

Some also include options for printing additional info.

For example:

```bash
./001 --max=10
./002 --max=100
./003 --num=13195
./004 --width=2
./005 --rangeMax=10
./006 --rangeMax=10
./007 --n=6
./008 --digits=4
./008 --digits=4 --printDigits
```

Disclaimer
----------

These solutions are done in my own free time for fun. They do not necessarily
represent the best possible solutions that could be written in Chapel (nor are
they necessarily the best algorithms).

That being said, I do try to use parallel constructs where possible. The
solutions are written (for the most part) for my laptop, so not attempt is made
to use constructs that take advantage of distributed memory or multiple
nodes. It would be pretty easy to add that kind of support for most solutions
though.

License
-------

Refer to the `LICENSE` file.
