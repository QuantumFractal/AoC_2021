module day01

using AoC_2021

function solve(input::String = getRawInput(1))
    values = parse.(Int, split(input))
    return [part1(values), part2(values)]
end

""" Kind of a naive solution, using manual indexing
    which can be _slightly_ unsafe
"""
function part1(values::Array{Int, 1})
    increased = 0
    for i in 1:length(values)-1
        if values[i] < values[i+1]
            increased += 1
        end
    end

    return increased
end

""" Now using views, which are a non-allocating structure!
"""
function part2(values::Array{Int, 1})
    increased = 0
    prev_sum = typemax(Int32)

    for i in 1:length(values)-2
        v = @view values[i:i+2]
        current_sum = sum(v)
    
        if current_sum > prev_sum
            increased += 1
        end

        prev_sum = current_sum
    end

    return increased
end

end # module