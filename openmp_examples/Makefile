FCFLAGS = -O2 -fopenmp
FC = gfortran

ALL = hello naive_example pi atomic  

all: $(ALL)

pi: pi.o
	$(FC) $(FCFLAGS) $^ -o $@
	OMP_NUM_THREADS=1 ./$@
	OMP_NUM_THREADS=2 ./$@
	OMP_NUM_THREADS=4 ./$@

naive_example: naive_example.o
	$(FC) $(FCFLAGS) $^ -o $@
	OMP_NUM_THREADS=1 ./$@
	OMP_NUM_THREADS=2 ./$@
	OMP_NUM_THREADS=4 ./$@

hello: hello.o
	$(FC) $(FCFLAGS) $^ -o $@
	OMP_NUM_THREADS=8 ./$@

atomic: atomic.o
	$(FC) $(FCFLAGS) $^ -o $@
	OMP_NUM_THREADS=4 ./$@
	OMP_NUM_THREADS=8 ./$@

%.o:%.f90
	$(FC) $(FCFLAGS) -c $^

.PHONY: clean
clean:
	rm -f *.o *~
	rm -f $(ALL)
