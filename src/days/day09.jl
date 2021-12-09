module day09

using AoC_2021
using StatsBase
using Statistics


function solve(input::String = getRawInput(9))
    return [part1(input), part2(input)]
end


function part1(input)
    mat = map(c -> parse(Int, c), hcat(collect.(split(input))...))
    width, height = size(mat)

    total_risk = 0
    for i in 1:width
        for j in 1:height
            center = get(mat, CartesianIndex(i,j), 0)
            up = get(mat, CartesianIndex(i,j+1), 10)
            down = get(mat, CartesianIndex(i,j-1), 10)
            left = get(mat, CartesianIndex(i+1,j), 10)
            right = get(mat, CartesianIndex(i-1,j), 10)

            if (center < up) && (center < down) && (center < left) && (center < right)
                total_risk += center + 1
            end
        end
    end

    return total_risk
end


""" For people who checked this solution before I cleaned it up, LMAO
    This is my first time writing a flood fill. It's not pretty, it's fast (enough)
    and it's correct
"""
function part2(input)
    mat = map(c -> c == '9', hcat(collect.(split(input))...))

    visited = Dict(idx => false for idx in CartesianIndices(size(mat)))

    width, height = size(mat)

    UP = CartesianIndex(0, 1)
    RIGHT = CartesianIndex(1, 0)

    queue = []
    pool_sizes = []
    for i in 1:width
        for j in 1:height
            idx = CartesianIndex(i, j)

            val = get(mat, idx, true)

            if visited[idx] || val == true
                continue
            end

            # Flood fill I guess?
            queue = [idx]
            sz = 0
            while length(queue) != 0
                current = popat!(queue, 1)

                if visited[current] == true
                    continue
                end

                sz += 1
                visited[current] = true
                val = mat[current]
                if val == true
                    continue
                end
                if val == false
                    if !get(mat, current + UP, true)
                        push!(queue, current + UP)
                    end
                    if !get(mat, current - UP, true)
                        push!(queue, current - UP)
                    end
                    if !get(mat, current + RIGHT, true)
                        push!(queue, current + RIGHT)
                    end
                    if !get(mat, current - RIGHT, true)
                        push!(queue, current - RIGHT)
                    end
                end
            end

            if sz > 1
                push!(pool_sizes, sz)
            end
        end
    end

    topvals = sort(pool_sizes, rev=true)[1:3]
    return topvals[1] * topvals[2] * topvals[3]
end

end # module