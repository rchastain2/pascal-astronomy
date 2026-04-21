
DM := ../delphimoon
## https://github.com/wp-xyz/delphimoon

UNITS := units
OUT := out

SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

PFLAGS := -Mobjfpc -Sh
PFLAGS += -Fu$(DM)
PFLAGS += -FU$(UNITS)
PFLAGS += -vq
PFLAGS += -vm5025
PFLAGS += -vm5027

default: out/eclipses.md
all: $(TARGETS)

$(DM):
	$(warning Directory not found: $(DM))
	$(error Please provide a valid path to DelphiMoon units)

ifeq ($(OS),Windows_NT)
MKDIR = if not exist $(1) mkdir $(1)
else
MKDIR = [ -d $(1) ] || mkdir -p $(1)
endif

$(UNITS) $(OUT):
	$(info Create directory: $@)
	$(call MKDIR,$@)

%: %.pas $(DM) $(UNITS) Makefile
	@fpc $(PFLAGS) $<

out/eclipses.md: eclipses $(OUT)
	./$< > $@

clean:
	@rm -fv $(UNITS)/*.o $(UNITS)/*.ppu

distclean: clean
	@rm -fv $(TARGETS) *.exe
