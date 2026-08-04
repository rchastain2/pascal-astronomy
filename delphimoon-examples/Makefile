
DMOON := ../delphimoon
## https://github.com/wp-xyz/delphimoon

SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

UNITS := units

PFLAGS := -Mobjfpc -Sh
PFLAGS += -Fu$(DMOON)
PFLAGS += -FU$(UNITS)
PFLAGS += -vq
PFLAGS += -vm5025
PFLAGS += -vm5027

default: eclipses

all: $(TARGETS)

$(DMOON):
	$(warning Directory not found: $(DMOON))
	$(error Please provide a valid path to DelphiMoon units)

$(UNITS):
	mkdir $@

%: %.pas $(DMOON) $(UNITS) Makefile
	fpc $(PFLAGS) $<

.PHONY: DOC.md
DOC.md:
	printf '\n%s\n' '# DelphiMoon documentation' > $@
	cat doc/*.md >> $@

clean:
	rm -fv $(UNITS)/*.o $(UNITS)/*.ppu

distclean: clean
	rm -fv $(TARGETS) *.exe
