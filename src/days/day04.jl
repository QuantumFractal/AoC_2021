module day04

using AoC_2021
using Base.Iterators
using StatsBase

make_boards(test_string) = collect(map(make_board, Iterators.partition(filter(r->r != "", split(test_string, r"\n")[2:end]), 5)))
make_board(rows) = hcat(map(row -> parse.(Int, split(strip(row), r"\s+")), rows)...)
get_draws(test_string) = parse.(Int, split(split(test_string, "\n")[1], ","))

compute_score(winner, hitlist) = sum(getindex(winner, filter(idx -> idx ∉ hitlist, vec(CartesianIndices(winner)))))

check_dim(hits, dim) = any(Iterators.map(x -> x[2] >= 5, countmap(getindex.(hits, dim))))

function solve(input::String = getRawInput(4))
    boards = make_boards(input)
    draws = get_draws(input)
    return part2(boards, draws)
end


function part1(boards, draws)
    hitlist = [Vector{CartesianIndex}() for x in 1:length(boards)]

    for draw in draws
        for (i, board) in enumerate(board)
            push!(hitlist[i], findall(x -> x == draw, boards[i])...)
            if check_dim(hitlist[i], 1) || check_dim(hitlist[i], 2)
                # winner winner
                return compute_score(boards[i], hitlist[i]) * draw
            end
        end
    end
    return -1
end


function part2(boards, draws)
    hitlist = [Vector{CartesianIndex}() for x in 1:length(boards)]
    not_won = collect(1:length(boards))

    for draw in draws
        for (i, board) in enumerate(boards)
            push!(hitlist[i], findall(x -> x == draw, board)...)
        end

        for i in not_won
            if check_dim(hitlist[i], 1) || check_dim(hitlist[i], 2)
                # winner winner
                if length(not_won) == 1
                    loser_idx = not_won[1]
                    return compute_score(boards[loser_idx], hitlist[loser_idx]) * draw
                else
                    popat!(not_won, findall(x->x==i, not_won)[1])
                end
            end
        end

    end
    return -1
end

end # module