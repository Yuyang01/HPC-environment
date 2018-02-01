FCFLAGS = -O3 
FC = mpif90

ALL = hello pi ring_deadlock ring_deadlock_free pi_nonblocking

all: $(ALL)

pi: pi.o
	$(FC) $(FCFLAGS) $^ -o $@

hello: hello.o
	$(FC) $(FCFLAGS) $^ -o $@
	mpirun -np 4 ./$@

ring_deadlock: ring_deadlock.o
	$(FC) $(FCFLAGS) $^ -o $@

ring_deadlock_free: ring_deadlock_free.o
	$(FC) $(FCFLAGS) $^ -o $@

pi_nonblocking: pi_nonblocking.o
	$(FC) $(FCFLAGS) $^ -o $@

%.o:%.f90
	$(FC) $(FCFLAGS) -c $^

.PHONY: clean
clean:
	rm -f *.o *~
	rm -f $(ALL)
