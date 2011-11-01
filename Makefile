CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SOURCES=$(wildcard *.cpp)
OBJECTS=$(addprefix $(OUTDIR)/, $(SOURCES:.cpp=.o))
EXECUTABLE=$(OUTDIR)/non-intrusive-pch.exe

ifdef USE_PCH
    PRECOMPILED_HEADER=precompiled.h
    PCH_TARGET=$(PRECOMPILED_HEADER).gch
    CFLAGS+= -include $(PRECOMPILED_HEADER)
    OUTDIR=out/gcc-pch
    $(info Building WITH precompiled headers...)
else
    $(info Building WITHOUT precompiled headers...)
    OUTDIR=out/gcc-no-pch
endif

all: $(EXECUTABLE)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

$(PCH_TARGET): $(PRECOMPILED_HEADER)
	$(CC) $(CFLAGS) $< -o $@

$(OUTDIR)/%.o: %.cpp $(OUTDIR) $(PCH_TARGET)
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJECTS) $(EXECUTABLE) $(PCH_TARGET)

.PHONY: clean all
