module day04

using AoC_2021
using Base.Iterators

const BOARD_SIZE = 5
const BOARD_IDX = CartesianIndices((BOARD_SIZE,  BOARD_SIZE))

function solve(input::String = getRawInput(4))
    first, rest... = split(input, "\n\n")
    draws = parse.(Int, split(first, ","))

    boards, reverse_index = make_boards(rest)
    part1_answer = part1(boards, reverse_index, draws)

    # Re-parse the boards / index since we update them to do some bookkeeping
    boards, reverse_index = make_boards(rest)
    part2_answer = part2(boards, reverse_index, draws)

    return [part1_answer, part2_answer]
end


""" It turns out that datastructures are important!

    This problem is just a search problem. Boards are documents,
    and bingo numbers are terms. In a second pass, I refactored the
    board datastructure to just be a map/dict from the bingonumber -> coordinate.
    In order to update the hitlist, we just need the coordinate of the bingo
    number on the board. Dicts are generally pretty good at this kind of thing!

    To speed things up a bit more, I built another index mapping bingo numbers to
    a list of boards that contain that number. So when we get a draw, we literally just
    say `reverse_index[number]`, and we get all boards containing that number! 
    In hindsight, "reverse_index" is kind of bad name.

    By doing this work up front, when we're scanning the boards in, we MASSIVELY
    speed up our lookups when finding hits.
"""
function make_boards(rows)
    boards = Vector(undef, length(rows))
    reverse_index = Dict{Int64, Vector{Int64}}()

    for (board_idx, row) in enumerate(rows)
        board = Dict{Int64, Vector{CartesianIndex}}()
        for (idx, value) in enumerate(parse.(Int, split(strip(row), r"\s+")))
            # Build the document
            if value in keys(board)
                push!(board[value], BOARD_IDX[idx])
            else
                board[value] = [BOARD_IDX[idx]]
            end

            # aaaand the bingo number index
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


""" In fit of rage, I refactored the "hitlist" datastructure.

    Previously, the hitlist was a Vector{CartesianIndex}, which I then had to
    compute a bunch of stuff to figure out the remaining bingo numbers, etc.

    Now: the hitlist is just a BOARD_SIZE * 2 (dimentions) x length(boards) matrix.
    Each value represents the number of hits within that row or column. For simplicity,
    I just combined the rows and col counts into one (hence the +BOARD_SIZE) offset in
    `hit!`. 
"""
function hit!(hitlist, b_idx, h_idx)
    hitlist[h_idx[1],            b_idx] += 1
    hitlist[h_idx[2]+BOARD_SIZE, b_idx] += 1
end


""" Because of the hitlist refactoring, checking a win is super easy, we just need to check if
    any row or column has 5 hits, that means the row/column is full!
"""
check_win(hitlist, b_idx) = any(map(c -> c == BOARD_SIZE, hitlist[:, b_idx]))


""" Putting it all together:

    We go through all the drawn numbers.
    - For each draw, we quickly look up all the boards that contain that draw (thanks to our
          handy "reverse_index")
    - Using the board datastructure, we get all coordinates for the given draw, and update the hitlist.

    After the hitlist is updated, we can check to see if it's a winner.
    We also do some bookkeeping to remove checked numbers from the board and index, since we don't have 
    duplicate draws.
"""
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

""" Part 2 is basically the same as Part 1

    The difference is that we keep a vector of winning board numbers.
    On a _first_ win, we add the winner to the list, and keep going.

    If the winner happens to be the last one, we compute the answer
    and return.
"""
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