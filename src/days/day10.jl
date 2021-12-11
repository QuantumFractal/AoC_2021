module day10

using AoC_2021
using StatsBase
using Statistics


function solve(input::String = getRawInput(10))

    lines = split(input, "\n")

   
    return [part1(lines), part2(lines)]
end


function scan(line)
    stack = []

    open  = ['(', '{', '[', '<']
    close = [')', '}', ']', '>']

    matching = Dict((')' => '(', ']' => '[', '}' => '{', '>' => '<'))
    for char in collect(line)
        if char ∈ open
            push!(stack, char)
        end
        if char ∈ close
            if pop!(stack) != matching[char]
                return char
            end
        end
    end
    return nothing
end



function part1(lines)
    high_scores = Dict((')' => 0, '}' => 0, ']' => 0 , '>' => 0))
    multipliers = Dict((')' => 3, ']' => 57, '}' => 1197 , '>' => 25137))
    bad_lines = 0
    total_lines = 0

    for line in lines
        total_lines += 1

        loser = scan(line)
        if loser !== nothing
            bad_lines += 1
            high_scores[loser] += 1
        end
    end
    return Int(sum(Iterators.map(pair -> multipliers[pair.first] * pair.second, high_scores)))
end

function scan2(line)

    return nothing
end

function part2(lines)
    high_scores = Dict(('(' => 1, '[' => 2, '{' => 3 , '<' => 4))
    open  = ['(', '{', '[', '<']
    close = [')', '}', ']', '>']
    matching = Dict((')' => '(', ']' => '[', '}' => '{', '>' => '<'))

    scores = []
    result = 0
    for line in lines
        corrupted = false
        stack = []

        last_char = nothing
        for char in collect(line)
            if char ∈ open
                push!(stack, char)
            end
            if char ∈ close
                if pop!(stack) != matching[char]
                    corrupted = true
                    break
                end
            end
            last_char = char
        end

        if !corrupted
            push!(scores, 0)
            reverse!(stack)
            for c in stack
                scores[end] *= 5
                scores[end] += high_scores[c]
            end
        end
    end

    sort!(scores)
    return scores[floor(Int, length(scores) / 2)+1]
end

end # module