module day11

using AoC_2021


const OUT = 9
const UP = CartesianIndex(0, 1)
const DOWN = CartesianIndex(0, -1)
const LEFT = CartesianIndex(-1, 0)
const RIGHT = CartesianIndex(1, 0)
const NEIGHBORHOOD = [UP, DOWN, LEFT, RIGHT, UP + LEFT, UP + RIGHT, DOWN + LEFT, DOWN + RIGHT]

function solve(input::String = getRawInput(11))

    mat = map(c -> parse(Int, c), hcat(collect.(split(input))...))

    return [part1(mat)]
end




function part1(mat)

    total_flashes = 0
    # 10 steps should be 204
    # 100 steps should be 1656
    for i in 1:3
        # println("Step: $i - Flashes $flashes")
        display(mat')

        #broadcast a +1
        mat .+= 1

        # Only look for the flashers...
        flashers = collect(filter(idx -> mat[idx] > 9, CartesianIndices(mat)))
        flashed = []
    
        println("Found $(length(flashers))")
        while length(flashers) > 0
            flasher = pop!(flashers)

            mat[filter(n -> get(mat, n, -1) > 0, .+([flasher], NEIGHBORHOOD))] .+= 1
            mat[flasher] = -1
            #push!(flashed, flasher)

             
        end
            # for neighbor in .+([flasher], NEIGHBORHOOD)
                
            # end
        mat[[flashed...]] .= 0
        # while length(flashers) > 0
        #     for flasher in flashers
        #         for neighbor in .+([flasher], NEIGHBORHOOD)
        #             if checkbounds(Bool, mat, neighbor) && mat[neighbor] > 0
        #                 mat[neighbor] += 1
        #             end
        #         end
        #         mat[flasher] = -1
        #         flashes += 1
        #     end

        #     flashers = filter(idx -> mat[idx] > 9, CartesianIndices(mat))
        #     mat = map(n -> n == -1 ? 0 : n, mat)
        # end
        total_flashes += length(flashed)
    end 


    return total_flashes
end


function part2(lines)

end

end # module