#!/bin/bash
EXEC="./pi-mc-mpi"

inputs=(
    100000000    # 100 mi
    6000000000   # 6 bi
    10000000000  # 10 bi
    60000000000  # 60 bi
)

run_cmds=(
    "mpirun -np 2"
    "mpirun --use-hwthread-cpus"
)

run_test() {
    local cmd="$1"
    local n_total="$2"

    echo "========================================"
    echo "Running: $cmd $EXEC $n_total"
    echo "----------------------------------------"

    for i in {1..5}; do
        echo "Start run $i for n_total=$n_total"
        $cmd $EXEC "$n_total"
        echo "Concluded run $i for n_total=$n_total"
        echo "----------------------------------------"
    done

    echo ""
}

for n in "${inputs[@]}"; do
    for rc in "${run_cmds[@]}"; do
        run_test "$rc" "$n"
    done
done