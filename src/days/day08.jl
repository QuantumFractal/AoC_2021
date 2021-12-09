module day08

using AoC_2021
using StatsBase
using Statistics


function solve(input::String = getRawInput(8))
    lines = split(input, "\n")

    inputs = []
    outputs = []

    # Bit messy, but basically we're converting each string into a set of chars
    for line in lines
        d = Dict()
        digits, output = split(line, "|")
        push!(outputs, map(num -> Set(collect(num)), split(strip(output), " ")))
        digits = map(num -> Set(collect(num)), split(strip(digits), " "))
        for digit in digits
            l = length(digit)
            if l ∉ keys(d)
                push!(d, l => [digit])
            else
                push!(d[l], digit)
            end
        end
        push!(inputs, d)
    end

    return [part1(input, outputs), part2(inputs, outputs)]
end


function part1(_, outputs)
    unique = Set([2,3,4,7])
    return sum(map(output -> length(filter(d -> length(d) in unique, output)), outputs))
end


""" `make_digit_map` does most of the heavy lifting here, it's figuring out
    how the digits are scrambled, and we just use the map to get the output
    numbers and sum them.
"""
function part2(inputs, outputs)


    total = 0
    for i in 1:length(inputs)
        dm = make_digit_map(inputs[i])
        total += parse(Int, join(map(out -> dm[out], outputs[i])))
    end

    return total
end


""" 
    Couldn't be bothered to clean this up honestly, a lot of the logic
    here is worked out by hand, figuring a method to extract the mapping 
    between scrambled letters to number. 

    The number "one" is doing a lot of heavy lifting here. Since numbers like
    2 or 5 have the same number of segments, but are flipped, we can use the
    fact that number 1 contains a set of the right two segments. 

    We can then deduce 9 and 6 based on which set represents number 5. Since 5's
    segments is a subset of both 9 and 6. We can also use this to figure out which
    string is 0.
"""
function make_digit_map(input)
    digit_map = Dict()

    # These are freebies, since they're unique
    push!(digit_map, first(input[2]) => 1)
    push!(digit_map, first(input[4]) => 4)
    push!(digit_map, first(input[3]) => 7)
    push!(digit_map, first(input[7]) => 8)


    one = first(input[2])
    three = first(filter(num -> length(intersect(one, num)) == 2, input[5]))
    push!(digit_map, three => 3)

    for num in filter(num -> num != three, input[5])
        # 5 is 2 subsets of 9 and 6, not 0
        nine_six = filter(c -> issubset(num, c), input[6])
        if length(nine_six) == 2
            push!(digit_map, num => 5)
            push!(digit_map, first(filter(num -> num ∉ nine_six, input[6])) => 0)
            push!(digit_map, first(filter(num -> length(intersect(one, num)) == 2, nine_six)) => 9)
            push!(digit_map, first(filter(num -> length(intersect(one, num)) == 1, nine_six)) => 6)
        else
            push!(digit_map, num => 2)
        end
    end

   return digit_map
end

end # module