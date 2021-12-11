module day09

using AoC_2021
using StatsBase
using Statistics


const OUT = 9
const UP = CartesianIndex(0, 1)
const DOWN = CartesianIndex(0, -1)
const LEFT = CartesianIndex(-1, 0)
const RIGHT = CartesianIndex(1, 0)
const KERNEL = [UP, DOWN, LEFT, RIGHT]


function solve(input::String = getRawInput(9))
    # Fairly standard split / parse to Int
    mat = map(c -> parse(Int, c), hcat(collect.(split(input))...))

    seeds, part1_answer = part1(mat)
    return [part1_answer, part2(seeds, mat)]
end

""" Part 1 is fairly easy, we iterate over all the grids,
    check their neighborhood (4 surrounding cells) adding
    ones where they're less than their surroundings.
"""
function part1(mat)
    seeds = []
    total_risk = 0
    for idx in CartesianIndices(mat)
        center = get(mat, idx, 0)

        # This line is generating the 4-neighbors, and checking their values against
        # the center one. If all 4 neighbors are larger, it's a "risk"
        if length(filter(idx -> get(mat, idx, OUT) > center, .+([idx], KERNEL))) == 4
            total_risk += center + 1
            push!(seeds, idx)
        end
    end

    # We'll use the seeds later :)
    return seeds, total_risk
end


""" Part2 is a bit more complicated, but we can use the seeds from part1
    to have a great starting point for our flood fill!
"""
function part2(seeds, mat)
    pool_sizes = []

    # Instead of iterating over the entire map again,
    # start with areas of interest.
    for seed in seeds
        val = mat[seed]
        if val == OUT
            continue
        end

        # This is a very standard 4-way flood fill.
        # We maintain our own queue because Julia (well and LLVM) 
        # isn't optimized for Tail-Calls 
        queue = [seed]
        sz = 0
        while length(queue) != 0
            cur = popat!(queue, 1)
            if mat[cur] != OUT
                # Increment the size of the pool, this is the only important 
                # piece of information we want out of this operation.
                sz += 1

                # We're using the same line from part1 to figure out valid neighbords and
                # add them to be processed.
                push!(queue, filter(idx -> get(mat, idx, OUT) != OUT, .+([cur], KERNEL))...)
            end

            mat[cur] = OUT
        end

        if sz > 1
            push!(pool_sizes, sz)
        end
    end

    # Find the top 3, and multiply them together.
    return reduce(*, sort(pool_sizes, rev = true)[1:3])
end

end # module