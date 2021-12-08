module day07

using AoC_2021
using StatsBase

function get_fuel(s, e)
    last = 0
    fuel = 0
    for i in 1:abs(s - e)
        last = last + 1
        fuel += last
    end
    return fuel
end


function solve(input::String = getRawInput(7))
    test_data = parse.(Int, split(input, ","))
    m_range = findmin(test_data)[1]:findmax(test_data)[1]

    least = typemax(Int32)
    for i in m_range
        total = 0
        for val in test_data

            fuel = get_fuel(val, i)
            total += fuel
        end
        least = min(least, total)
    end

    return least
end





end