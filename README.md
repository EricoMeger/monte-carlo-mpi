# Monte Carlo Pi Estimation with MPI

This project implements the Monte Carlo method to estimate the value of Pi. It provides two implementations: a sequential (linear) version and a parallel version using MPI.

The algorithm generates random points within a square and counts how many fall inside the inscribed circle. The ratio of points inside the circle to the total number of points approximates $\pi/4$.

## Prerequisites

To compile and run this project, you need:

* **g++** (GCC) supporting C++17.
* **MPI Implementation** (MPICH).
* **Make**.

## 1. Linear Execution (Sequential)

The linear version runs on a single core.

1.  Navigate to the linear directory:
    ```bash
    cd code/linear
    ```

2.  Compile the code:
    ```bash
    make
    ```

3.  Run the executable:
    ```bash
    ./pi-mc-linear
    ```

*Note: The number of particles is currently hardcoded in `pi-mc-linear.cpp`. To change it, edit the `n_total` variable in the source code and recompile.*

## 2. Parallel Execution (Local Machine)

The parallel version distributes the particle generation across multiple processes on a single machine.

1.  Navigate to the mpi directory:
    ```bash
    cd code/mpi
    ```

2.  Compile the code:
    ```bash
    make
    ```

3.  Run using `mpirun`. You can specify the number of processes (`-np`) and the number of particles (as an argument):

    ```bash
    # Syntax: mpirun -np <number_of_processes> ./pi-mc-mpi <number_of_particles>
    
    # Example: Run 4 processes with 100 million particles
    mpirun -np 4 ./pi-mc-mpi 100000000
    ```

    * It will default to 60bi particles if none is specified.

4.  **Using Hyper-threading:**
    If you want to use more processes than physical cores (utilizing hyper-threading), use the `--use-hwthread-cpus` flag:
    ```bash
    mpirun --use-hwthread-cpus ./pi-mc-mpi 60000000000
    ```

### Automated Testing
A script is provided to run benchmarks automatically:
```bash
./run_tests.sh
```

#### 3. Distributed Execution (Local LAN)

To run the application across multiple computers (e.g., a Desktop and a Notebook) over a local network:

### Configuration steps:
1. **SSH Setup**: Ensure passwordless SSH is configured between the master node and the worker nodes.

2. **Compilation**: Compile the source code locally on each machine to ensure binary compatibility with the specific OS and MPI versions installed on that node.

3. **File Paths:** Ensure the executable is located at the exact same absolute path on all machines (or use a shared NFS directory).

> Refer to: [Running an MPI Cluster within a LAN](#running-an-mpi-cluster-within-a-lan)

### Execution

1. Create a hostfile (e.g., hosts) listing the IP addresses or hostnames and the number of slots (processes) for each:

```bash
# example hostfile
192.168.0.10 slots=4
192.168.0.11 slots=2
```

2. Run the MPI command from the master node pointing to the hostfile:

```bash
mpirun -np 6 --hostfile <hostfile> --use-hwthread-cpus ./pi-mc-mpi <particles>
```

### References

#### Monte Carlo Theory (Pi)

[Estimating Pi using Monte Carlo methods - Medium](https://medium.com/the-modern-scientist/estimating-pi-using-monte-carlo-methods-dbdf26c888d6)

[Estimating value Pi using Monte Carlo - GeeksforGeeks](https://www.geeksforgeeks.org/dsa/estimating-value-pi-using-monte-carlo/)

[Estimating Pi using the Monte Carlo method - 101computing](https://www.101computing.net/estimating-pi-using-the-monte-carlo-method/)

[Calculating Pi accurately with Monte Carlo method - Reddit](https://www.reddit.com/r/learnpython/comments/rgahhy/calculating_pi_accurately_with_monte_carlo_method/)

[Marsenne Twister Algorithm](https://www.math.sci.hiroshima-u.ac.jp/m-mat/MT/emt.html)

#### PI Resources

[MPICH Installation - AskUbuntu](https://askubuntu.com/questions/1236553/mpich-installation)

[Compute Pi with an HPC Cluster - Mathieu Gaillard](https://www.mgaillard.fr/2022/03/18/compute-pi-monte-carlo-hpc.html)

[MPI Calculation of Pi - MathRule](https://mathrule.wordpress.com/2011/01/27/mpi-calculation-of-pi-using-the-monte-carlo-method/)

[Unable to use all cores with mpirun - StackOverflow](https://stackoverflow.com/questions/48835603/unable-to-use-all-cores-with-mpirun)

[Running an MPI Cluster within a LAN](https://mpitutorial.com/tutorials/running-an-mpi-cluster-within-a-lan/)