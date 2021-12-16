module day13

using AoC_2021


small_test = """6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
"""

# UP for y lines
# LEFT for x lines

function solve(input::String = getRawInput(13))
    dots_lines, fold_lines = split(input, "\n\n")

    dots = map(s -> CartesianIndex(.+(parse.(Int, split(s, ",")), 1)...), split(dots_lines, "\n"))
    width, height = max(map(d -> d[1], dots)...), max(map(d -> d[2], dots)...)

    paper  = fill(0, width, height)
    folds = map(line -> split(split(line, " ")[end], "="),  split(fold_lines, "\n"))

    #place initial dots
    for dot in dots
        paper[dot] = 1
    end

    return paper, folds
    return [part1(paper, folds), part2(paper, folds)]
end

function fold_once(paper, instruction)
    # Determine howb big the next piece is going to be
    axis, loc = instruction
    loc = parse(Int, loc)


    width, height = size(paper)

    # Fold along the 1st dim
    if axis == "x"
        loc_diff = width - loc - loc
        bottom = paper[loc+2:end, :][end:-1:1, :]
        top = paper[loc_diff:loc, :]
        top .+= bottom

        if loc_diff != 1
            return hcat(paper[1:loc_diff, :], top)
        else
            return top
        end
    elseif axis == "y"
        loc_diff = height - loc - loc
        bottom = paper[:, loc+2:end][:, end:-1:1]

        top = paper[:, loc_diff:loc]

        println("Top size $(size(top)), Bottom size $(size(bottom))")
        top .+= bottom

        if loc_diff != 1
            return hcat(paper[:, 1:loc_diff], top)
        else
            return top
        end
    end

end

function part1(paper, folds)
    once_folded = fold_once(paper, folds[1])
    return length(filter(c -> c > 0, once_folded))
end


function part2(paper, folds)
    for instruction in folds
        paper = fold_once(paper, instruction)
    end
    return paper
end

end # module
