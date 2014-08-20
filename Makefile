
CHPL = chpl
CHPL_FLAGS = --fast

CWD = $(shell pwd)

SRCS := $(wildcard *.chpl)
PRGS := $(patsubst %.chpl,%,$(SRCS))

SRC = $(patsubst %,%.chpl,$@)

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
