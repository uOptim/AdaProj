FLAGS=-gnat2012 $(UFLAGS)
SRCS=$(wildcard *.adb *.ads)

.PHONY: all, clean

all: path

path: path.adb path.ads
	gnatmake $(FLAGS) $<

clean:
	rm -rf *.ali *.o
