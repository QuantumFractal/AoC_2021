module day04

using AoC_2021
using Base.Iterators
using StatsBase

""" So I noticed that each board has no duplicates, so we can just represent
    each board as a Dict mapping the number to an index, making it super
    fast to lookup! This will break for more
"""

const BOARD_SIZE = 5
const BOARD_IDX = CartesianIndices((BOARD_SIZE,  BOARD_SIZE))

function solve(input::String = getRawInput(4))
    first, rest... = split(input, "\n\n")
    draws = parse.(Int, split(first, ","))

    boards, reverse_index = make_boards(rest)
    part1_answer = part1(boards, reverse_index, draws)

    # Re-parse the boards / index since we modify them.
    boards, reverse_index = make_boards(rest)
    part2_answer = part2(boards, reverse_index, draws)

    return [part1_answer, part2_answer]
end


""" 
"""
function make_boards(rows)
    boards = Vector(undef, length(rows))
    reverse_index = Dict{Int64, Vector{Int64}}()

    for (board_idx, row) in enumerate(rows)
        board = Dict{Int64, Vector{CartesianIndex}}()
        for (idx, value) in enumerate(parse.(Int, split(strip(row), r"\s+")))
            # Build the forward index
            if value in keys(board)
                push!(board[value], BOARD_IDX[idx])
            else
                board[value] = [BOARD_IDX[idx]]
            end

            # aaaand the reverse index
            if value in keys(reverse_index)
                push!(reverse_index[value], board_idx)
            else
                reverse_index[value] = [board_idx]
            end
        end
        boards[board_idx] = board
    end
    return boards, reverse_index
end


""" TODO explain this
"""
function hit!(hitlist, b_idx, h_idx)
    hitlist[h_idx[1],            b_idx] += 1
    hitlist[h_idx[2]+BOARD_SIZE, b_idx] += 1
end

check_win(hitlist, b_idx) = any(map(c -> c == BOARD_SIZE, hitlist[:, b_idx]))

function part1(boards, reverse_index, draws)
    hitlist = zeros(Int64, BOARD_SIZE * 2, length(boards))

    for draw in draws
        for board_idx in reverse_index[draw]
            board = boards[board_idx]

            for pos in board[draw]
                hit!(hitlist, board_idx, pos)
            end

            pop!(board, draw)

            if check_win(hitlist, board_idx)
                return sum(keys(board)) * draw
            end
        end

        pop!(reverse_index, draw)
    end
    return -1
end


function part2(boards, reverse_index, draws)
    hitlist = zeros(Int64, BOARD_SIZE * 2, length(boards))
    winners = []

    for draw in draws
        for board_idx in reverse_index[draw]
            board = boards[board_idx]

            for pos in pop!(board, draw)
                hit!(hitlist, board_idx, pos)
            end

            if board_idx ∉ winners && check_win(hitlist, board_idx)
                push!(winners, board_idx)

                if length(winners) == length(boards)
                    return sum(keys(board)) * draw
                end
            end
        end

        pop!(reverse_index, draw)
    end
    return -1
end

end # module