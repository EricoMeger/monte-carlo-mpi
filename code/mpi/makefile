#makefile adapted from the author of this article:
#https://mathrule.wordpress.com/2011/01/27/mpi-calculation-of-pi-using-the-monte-carlo-method/

OBJS := pi-mc-mpi.o
EXECUTABLE := pi-mc-mpi

CXX := mpic++
CFLAGS := -O3 -march=native -std=c++17 -Wall
CPPFLAGS := -DPARALLEL
LDLIBS := -lm

%.o: %.cpp
	$(CXX) $(CFLAGS) $(CPPFLAGS) $(INCLUDES) -c $< -o $@

$(EXECUTABLE): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDLIBS)

run:
	mpirun -np 2 ./$(EXECUTABLE)

clean:
	-rm -f *.o $(EXECUTABLE)
