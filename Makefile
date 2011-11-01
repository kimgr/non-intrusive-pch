CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SRCS=$(wildcard *.cpp)
DEPS=$(addprefix $(OUTDIR)/, $(SRCS:.cpp=.d))
OBJS=$(addprefix $(OUTDIR)/, $(SRCS:.cpp=.o))
PROG=$(OUTDIR)/non-intrusive-pch.exe

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

all: $(PROG)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(PROG): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

$(PCH_TARGET): $(PRECOMPILED_HEADER)
	$(CC) $(CFLAGS) -MMD -MT$(@:.gch=.d) -o $@ $<

$(OUTDIR)/%.o: %.cpp $(PCH_TARGET) | $(OUTDIR)
	$(CC) $(CFLAGS) -MMD -MT$(@:.o=.d) -o $@ $< 

clean:
	rm -f $(OBJS) $(DEPS) $(PROG) $(PCH_TARGET) $(PCH_TARGET:.gch=.d)

.PHONY: clean all

-include $(DEPS)
