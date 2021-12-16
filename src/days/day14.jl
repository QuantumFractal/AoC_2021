module day14

using AoC_2021

using Base.Iterators
using StatsBase

# UP for y lines
# LEFT for x lines

function solve(input::String = getRawInput(14))
    first, rest = split(input, "\n\n")

    poly = split(first, "")

    rules = Dict()
    for insertion in split(rest, "\n")
        pair, rep = split(insertion, " -> ")
        push!(rules, pair => rep)
    end

    counts = Dict(k => 0 for k in keys(rules))
    scores = Dict(k => 0 for k in Set(values(rules)))

    for i in 1:length(poly)-1
        counts[join(poly[i:i+1])] += 1
    end

    for i in 1:length(poly)
        scores[poly[i]] += 1
    end

    for _ in 1:40
        new_counts = Dict(k => 0 for k in keys(rules))
        for (k, v) in counts
            
            x = rules[k]
            new_counts[k[1] * x] += v
            new_counts[x * k[2]] += v
            scores[x] += v
        end
        counts = new_counts
    end


    # return new_pairs
    # most common element vs least common
    return max(values(scores)...) - min(values(scores)...)
end

function part(poly, rules, steps)

end


function step(poly, insertions)
    inserts = find_inserts(poly, insertions)
    return splice_poly(inserts, poly)
end


function part1(paper, folds)
end


function part2(paper, folds)

end

end # module
