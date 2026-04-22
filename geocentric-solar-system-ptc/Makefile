
PC = fpc

ifdef LCL
LAZARUS := ~/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := ~/Documents/pascal/sources/fpgui/develop
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
AGGEXT := $(FPGUI)/extras/aggpas
endif

PFLAGS := -Mobjfpc -Sh
PFLAGS += -FUunits
PFLAGS += -ghl

PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)/platform/linux
PFLAGS += -Fu$(AGGPAS)/ctrl
PFLAGS += -Fu$(AGGPAS)/util
ifndef LCL
PFLAGS += -Fu$(AGGEXT)
endif

SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

default: demo

%: %.pas
ifeq ($(OS),Windows_NT)
	@if not exist units mkdir units
else
	@[ -d units ] || mkdir -p units
endif
	@$(PC) $(PFLAGS) $<

clean:
	@rm -fv *.bak *.bak? *.log

distclean: clean
	@rm -fv $(TARGETS) units/*.o units/*.ppu
