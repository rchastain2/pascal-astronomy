
PC := fpc

SDL2 := ~/Documents/pascal/sources/sdl2/units
# https://github.com/PascalGameDevelopment/SDL2-for-Pascal
# git clone https://github.com/PascalGameDevelopment/SDL2-for-Pascal.git

ifdef LCL
LAZARUS := ~/Documents/sources/lazarus
# https://gitlab.com/freepascal.org/lazarus/lazarus
# git clone https://gitlab.com/freepascal.org/lazarus/lazarus.git
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := ~/Documents/pascal/sources/fpgui/develop
# https://github.com/graemeg/fpGUI
# git clone https://github.com/graemeg/fpGUI.git
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
endif

PFLAGS := -Mobjfpc -Sh -ghl
PFLAGS += -FUunits

PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)

PFLAGS += -Fu$(SDL2)

SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

all: $(TARGETS)

$(SDL2):
	$(warning Directory not found: $(SDL2))
	$(error Please provide a valid path to SDL2 units)

$(AGGPAS):
	$(warning Directory not found: $(AGGPAS))
	$(error Please provide a valid path to AGGPas units)

%: %.pas $(SDL2) $(AGGPAS)
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
