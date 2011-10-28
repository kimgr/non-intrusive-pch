CC=g++
CFLAGS=-c -Wall -ftime-report
LDFLAGS=
OUTDIR=out-no-pch
SOURCES=$(wildcard *.cpp)
OBJECTS=$(SOURCES:.cpp=.o)
OBJECTPATHS=$(addprefix $(OUTDIR)/, $(OBJECTS))
EXECUTABLE=$(OUTDIR)/non-intrusive-pch.exe

ifdef USE_PCH
    PRECOMPILED_HEADER=precompiled.h
    PCH_TARGET=$(PRECOMPILED_HEADER).gch
    CFLAGS+= -include $(PRECOMPILED_HEADER)
    OUTDIR=out-pch
    $(info Building WITH precompiled headers...)
else
    $(info Building WITHOUT precompiled headers...)
endif

all: $(EXECUTABLE)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(EXECUTABLE): $(OBJECTS) $(OUTDIR)
	$(CC) $(LDFLAGS) $(OBJECTPATHS) -o $@

%.o: %.cpp $(OUTDIR) $(PCH_TARGET)
	$(CC) $(CFLAGS) $< -o $(OUTDIR)/$@

$(PCH_TARGET): $(PRECOMPILED_HEADER)
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJECTPATHS) $(EXECUTABLE) $(PCH_TARGET)

.PHONY: clean
