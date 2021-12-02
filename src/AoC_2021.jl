module AoC_2021

using BenchmarkTools
using Printf

include("utils.jl")
export getRawInput

solvedDays = 1:2

""" Stole goggle's AoC exporting / benchmarking from last year
    https://github.com/goggle/AdventOfCode2020.jl/blob/master/src/AdventOfCode2020.jl
"""

for day in solvedDays
    ds = @sprintf("%02d", day)
    include(joinpath(@__DIR__, "days/", "day$ds.jl"))
end

println(AoC_2021.day1.solve())

# Benchmark a list of different problems:
function benchmark(days=solvedDays)
    results = []
    for day in days
        modSymbol = Symbol(@sprintf("day%02d", day))
        @eval begin
            bresult = @benchmark(AoC_2021.$modSymbol.solve())
        end
        push!(results, (day, time(bresult), memory(bresult)))
    end
    return results
end

# Write the benchmark results into a markdown string:
function _to_markdown_table(bresults)
    header = "| Day | Time | Allocated memory |\n" *
             "|----:|-----:|-----------------:|"
    lines = [header]
    for (d, t, m) in bresults
        ds = string(d)
        ts = BenchmarkTools.prettytime(t)
        ms = BenchmarkTools.prettymemory(m)
        push!(lines, "| $ds | $ts | $ms |")
    end
    return join(lines, "\n")
end

end # module
