module day07

using AoC_2021
using Statistics

function solve(input::String = getRawInput(7))
    data = parse.(Int, split(input, ","))
    return [part1(data), part2(data)]
end

function part1(data)
    _median = median(data)
    return Int(sum(map(x -> abs(x - _median), data)))
end

# Reduced "newtonian" to a closed form equation for simplicity.
function part2(data)
    avg = mean(data)
    avg_low, avg_hi = floor(avg), ceil(avg)

    project(x) = x * (x + 1) / 2
    under = Int(sum(map(x -> project(abs(x - avg_hi)), data)))
    over  = Int(sum(map(x -> project(abs(x - avg_low)), data)))

    return min(over, under)
end


end # module