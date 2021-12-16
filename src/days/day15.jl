module day15

using AoC_2021
using Base.Iterators

const OUT = 10
const UP = CartesianIndex(0, 1)
const DOWN = CartesianIndex(0, -1)
const LEFT = CartesianIndex(-1, 0)
const RIGHT = CartesianIndex(1, 0)
const KERNEL = [UP, DOWN, LEFT, RIGHT]


function solve(input::String = getRawInput(15))
    mat = map(c -> parse(Int, c), hcat(collect.(split(input))...))

    width, height = size(mat)
    # "full map"
    full_map = zeros(Int, size(mat) .* 5)
    for idx in CartesianIndices(mat)
        x, y = Tuple(idx)
        for i in 0:4
            for j in 0:4
                full_map[x + i * height, y + j * height] = ((mat[idx]-1+i+j)%9)+1
            end
        end
    end

    """
    full_cavern = [[((level-1+i+j)%9)+1 for i in range(5) for level in row] for j in range(5) for row in cavern]
    """

    start = CartesianIndex(1,1)
    _end = CartesianIndex(size(full_map)...)
    min_path = A_star(start, _end, full_map)
    
    return sum([full_map[idx] for idx in min_path]) - full_map[start]
end

function reconstruct_path(cameFrom, current)
    total_path = [current]
    while current in keys(cameFrom)
        current = cameFrom[current]
        pushfirst!(total_path, current)
    end
    return total_path
end

# First time doing A* wish me luck
function A_star(start, goal, mat)
    openSet = [start]
    cameFrom = Dict()

    gScore = Dict(idx => typemax(Int) for idx in CartesianIndices(mat))
    gScore[start] = 0

    fScore = Dict(idx => typemax(Int) for idx in CartesianIndices(mat))
    fScore[start] = mat[start]

    while length(openSet) > 0
        scores = sort([(node, fScore[node]) for node in openSet], by = t -> t[2])
        current = scores[1][1]

        if current == goal
            return reconstruct_path(cameFrom, current)
        end

        # remove 
        filter!(c -> c != current, openSet)
        for neighbor in .+([current], KERNEL)
            if get(mat, neighbor, OUT) != OUT
                tenative_gScore = gScore[current] + mat[neighbor]
                if tenative_gScore < gScore[neighbor]
                    cameFrom[neighbor] = current
                    gScore[neighbor] = tenative_gScore
                    fScore[neighbor] = tenative_gScore # + mat[neighbor]
                    if neighbor ∉ openSet
                        push!(openSet, neighbor)
                    end
                end
            end
        end
    end
end

end # module
