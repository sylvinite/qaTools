# Using gcc for now
CC=g++
# Flags for the compiles
CFLAGS=-c -Wall -g
INCLUDE=include/

all: removeUnmapped qaCompute computeInsertSizeHistogram doBWAQualTrimming

removeUnmapped: removeUnmapped.o
	$(CC) removeUnmapped.o -o removeUnmapped -L$(SAMTOOLS) -L$(SAMTOOLS)/htslib-$(VERSION) -lhts -lbam -lz

qaCompute: qaCompute.o
	$(CC) qaCompute.o -o qaCompute -L$(SAMTOOLS) -lbam -L$(SAMTOOLS)/htslib-$(VERSION) -lhts -lz #-lefence

computeInsertSizeHistogram: computeInsertSizeHistogram.o
	$(CC) computeInsertSizeHistogram.o -o computeInsertSizeHistogram -lz -L$(SAMTOOLS) -lbam -L$(SAMTOOLS)/htslib-$(VERSION) -lhts  #-fopenmp

doBWAQualTrimming: doBWAQualTrimming.o
	$(CC) doBWAQualTrimming.o -o doBWAQualTrimming -lz

removeUnmapped.o: removeUnmapped.c
	$(CC) -I$(SAMTOOLS) $(CFLAGS) removeUnmapped.c

qaCompute.o: qaCompute.c
	$(CC) -I$(SAMTOOLS) $(CFLAGS) qaCompute.c

computeInsertSizeHistogram.o: computeInsertSizeHistogram.c
	$(CC) -I$(SAMTOOLS) $(CFLAGS) computeInsertSizeHistogram.c

doBWAQualTrimming.o: doBWAQualTrimming.c
	$(CC) -I$(INCLUDE) $(CFLAGS) doBWAQualTrimming.c

clean:
	rm -rf *o removeUnmapped
	rm -rf *o qaCompute
	rm -rf *o computeInsertSizeHistogram
	rm -rf *o doBWAQualTrimming
