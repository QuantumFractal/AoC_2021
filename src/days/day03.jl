module day03

using AoC_2021

function solve(input::String = getRawInput(3))
    # Terrible way to build a matrix :/
    # At least I'm using Views for everything else!
    values = collect(hcat(map(row -> map(bit -> parse(Int, bit), split(row, "")), split(input, "\n"))...)')
    return [part1(values), part2(values)]
end

most(values)  = map(c ->(c >= (size(values)[1] // 2)) ? 1 : 0, sum(values, dims=1))
least(values) = map(c ->(c >= (size(values)[1] // 2)) ? 0 : 1, sum(values, dims=1))
to_int(values) = parse(Int, join(map(x -> Int(x), values)), base = 2)

""" So I figured out this map statement in the REPL, and infact finished part1
    entirely in the REPL, but I fat fingered the ctrl-c key, and lost my work.
    My partial part2 solution was making a wrong assumption anyways, but here's 
    the gist of the first one.
"""
function part1(values::Matrix{Int64})
    to_int(most(values)) * to_int(least(values))
end


""" For the second part, I really wanted to have no new allocations beyond
    the initial matrix construction. I'm doing this via Julia's slices/views.
    For example `values[:, 1]` will pick out the first bit from every row. This
    makes the filter step MUCH easier, because we're only filtering via indices,
    not entire rows. The underlying datastructure is the same, we're just slicing
    it in different ways. 

    After a basic simplification pass, I got 1.2ms and 1.45 Mb allocation which is
    basically nothing. I think I can make some further optimization passes though.
"""
function part2(values::Matrix{Int64})
    len, wid = size(values)
    m_rows = 1:len
    l_rows = 1:len

    for i in 1:wid
        if length(m_rows) > 1
            s = most(values[m_rows, i])[1]
            m_rows = getindex.(Iterators.filter(t -> t[2] == s, tuple.(m_rows, values[m_rows, i])), 1)
        end
        if length(l_rows) > 1
            s = least(values[l_rows, i])[1]
            l_rows =  getindex.(Iterators.filter(t -> t[2] == s, tuple.(l_rows, values[l_rows, i])), 1)
        end
    end
    return to_int(values[m_rows[1], :]) * to_int(values[l_rows[1], :])
end

end # module