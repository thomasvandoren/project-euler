
CHPL = chpl
CHPL_FLAGS = --fast --module-dir lib/

CWD = $(shell pwd)

SRCS := $(wildcard *.chpl)
PRGS := $(patsubst %.chpl,%,$(SRCS))

SRC = $(patsubst %,%.chpl,$@)

RUN_TESTS = bash $(CWD)/util/run_tests.bash

%: $(SRC)
	$(CHPL) $(CHPL_FLAGS) -o $@ $(SRC)

all: $(PRGS)
	@true

run-all: all
	@for chpl_prg in $(foreach prg,$(PRGS),$(prg)) ; do \
	echo Euler $$chpl_prg ; \
	echo --------- ; \
	./$$chpl_prg ; \
	echo ; \
	done

clean:
	@rm -f $(PRGS)

tests:
	$(RUN_TESTS)

lib-tests:
	$(RUN_TESTS) $(CWD)/lib/

all-tests:
	$(RUN_TESTS) $(CWD)/lib/ $(CWD)/test/
